//
//  DatabaseManager.swift
//  project
//
//  Created by Nazar Kopeika on 20.06.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase

enum Tables: String {
    case transfers = "transfers"
    case users = "users"
}

public class DatabaseManager {
    private let database = Firestore.firestore()
    static let shared = DatabaseManager()
    
    public func transferMoney(from senderId: String, to receiverId: String, amount: Int64, id: Int64, completion: @escaping (Error?) -> Void) { // with senderId
        getUserBalance(for: senderId) { senderBalance, senderError in
            guard senderError == nil else {
                completion(senderError)
                return
            }
            
            guard let senderBalance = senderBalance else {
                completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Sender not found"]))
                return
            }
            
            if senderBalance < amount {
                completion(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Transfer can't be done because you don't have enough balance."]))
                return
            }
            
            // Deduct the amount from the sender's balance
            let updatedSenderBalance = senderBalance - amount
            
            // Update the sender's balance in both the `users` collection and the `balances` collection
            self.updateBalance(for: senderId, newBalance: updatedSenderBalance) { senderUpdateError in
                if let senderUpdateError = senderUpdateError {
                    completion(senderUpdateError)
                    return
                }
                
                // Fetch the receiver's current balance
                self.getUserBalance(for: receiverId) { receiverBalance, receiverError in
                    guard receiverError == nil else {
                        completion(receiverError)
                        return
                    }
                    
                    // Add the transferred amount to the receiver's balance
                    let newReceiverBalance = (receiverBalance ?? 0) + amount
                    
                    // Update the receiver's balance in both the `users` collection and the `balances` collection
                    self.updateBalance(for: receiverId, newBalance: newReceiverBalance) { receiverUpdateError in
                        if let receiverUpdateError = receiverUpdateError {
                            // Revert sender's balance update in case of receiver's balance update error
                            self.updateBalance(for: senderId, newBalance: senderBalance) { _ in
                                completion(receiverUpdateError)
                            }
                        } else {
                            // Add the transaction record
                            self.addNewTransferRecord(id: id ,sender: senderId, receiver: receiverId, amount: amount)
                            completion(nil)
                        }
                    }
                }
            }
        }
    }
    
    public func getTransfers(completion: @escaping ([Transction]?, Error?) -> Void) { //default
        database.collection(Tables.transfers.rawValue).getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion([], nil)
                return
            }
            
            var transfers: [Transction] = []
            for document in documents {
                if let data = document.data() as? [String: Any],
                   let id = data["id"] as? Int64,
                   let sender = data["sender"] as? String,
                   let receiver = data["receiver"] as? String,
                   let amount = data["amount"] as? Int64 {
                    let transfer = Transction(id: id, sender: sender, receiver: receiver, amount: amount)
                    transfers.append(transfer)
                }
            }
            
            completion(transfers, nil)
        }
    }
    
    private func addNewTransferRecord(id: Int64, sender: String, receiver: String, amount: Int64) {
        let transferData: [String: Any] = [
            "id": id,
            "sender": sender,
            "receiver": receiver,
            "amount": amount
        ]
        
        let transferRef = database.collection(Tables.transfers.rawValue).document()
        transferRef.setData(transferData)
    }
    
    internal func getUsersTransfers(completion: @escaping ([User]) -> Void) {
        getUsers { users, error in
            guard error == nil else {
                completion([])
                return
            }
            
            completion(users)
        }
    }
    
    internal func getUsers(completion: @escaping ([User], Error?) -> Void) { //new, table of users is shown but without id and balance isnt updating
        database.collection(Tables.users.rawValue).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                completion([], error)
                return
            }
            
            var users: [User] = []
            
            for document in documents {
                if let data = document.data() as? [String: Any],
                   let name = data["name"] as? String,
                   let email = data["email"] as? String,
                   let id = data["id"] as? Int64,
                   let balance = data["balance"] as? Int64 {
                    let user = User(name: name, email: email, profilePictureRef: nil, id: id, balance: balance) // Set id to 0 for now, it will be updated later
                    users.append(user)
                }
            }
            
            // Fetch the user's id from Firestore based on their email
            let dispatchGroup = DispatchGroup()
            for i in 0..<users.count {
                dispatchGroup.enter()
                let user = users[i]
                let documentID = String(user.email)
                    .replacingOccurrences(of: ".", with: "_")
                    .replacingOccurrences(of: "@", with: "_")
                self.database.collection(Tables.users.rawValue).document(documentID).getDocument { snapshot, error in
                    if let document = snapshot, document.exists {
                        if let data = document.data(),
                           let idString = data["id"] as? String,
                           let id = Int64(idString) {
                            users[i].id = id // Update the user's id
                        }
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(users, nil)
            }
        }
    }
    
    func insert(user: User, completion: @escaping (Bool) -> Void) { //default
        let documentId = String(user.email)
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        let data: [String: Any] = [
            "name": user.name,
            "email": user.email,
            "id": user.id,
            "profilePictureRef": user.profilePictureRef ?? "",
            "balance": user.balance
        ]
        
        database
            .collection(Tables.users.rawValue)
            .document(documentId)
            .setData(data) { error in
                completion(error == nil)
            }
    }
    
    func updateBalance(for userId: String, newBalance: Int64, completion: @escaping (Error?) -> Void) {
        let documentId = String(userId)
        
        let userReference = database.collection(Tables.users.rawValue).document(documentId)
        userReference.getDocument { snapshot, error in
            if let error = error {
                // Error occurred while fetching the user document
                completion(error)
                return
            }
            
            if snapshot?.exists == true {
                // User document exists, update the balance in the existing document
                userReference.updateData(["balance": newBalance]) { error in
                    completion(error)
                }
            } else {
                // User document does not exist, create a new document with the user's ID and set the initial balance
                let userData: [String: Any] = [
                    "id": userId,
                    "balance": newBalance
                ]
                
                userReference.setData(userData) { error in
                    completion(error)
                }
            }
        }
    }
    
    func userExists(with email: String, completion: @escaping (Bool) -> Void) { //tyt
        let documentId = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")

        database.collection(Tables.users.rawValue).document(documentId).getDocument { snapshot, error in
            guard let _ = snapshot, error == nil else {
                completion(false) // User doesn't exist
                return
            }
            
            completion(true) // User exists
        }
    }
    
    public func getUserBalance(for userId: String, completion: @escaping (Int64?, Error?) -> Void) {
        let documentId = String(userId)
        let balanceReference = database.collection(Tables.users.rawValue).document(userId)
        
        balanceReference.getDocument { snapshot, error in
            if let data = snapshot?.data(),
               let balance = data["balance"] as? Int64 {
                completion(balance, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func getNextAvailableUserID(completion: @escaping (Int64) -> Void) {
        // Query the "users" collection to get the highest existing user ID
        database.collection(Tables.users.rawValue)
            .order(by: "id", descending: true)
            .limit(to: 1)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    completion(0) // Default value if there's an error
                    return
                }
                
                if let data = documents.first?.data(),
                   let highestID = data["id"] as? Int64 {
                    let newID = highestID + 1
                    completion(newID)
                } else {
                    completion(1) // Start with ID 1 if no existing users
                }
            }
    }


    
    internal func getUser(email: String, id: Int64, completion: @escaping (User?) -> Void) { //default
        let documentId = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        database
            .collection(Tables.users.rawValue)
            .document(documentId)
            .getDocument { snapshot, error in
                guard let data = snapshot?.data(),
                      let name = data["name"] as? String,
                      let balance = data["balance"] as? Int64 else {
                    completion(nil)
                    return
                }
                
                let profilePictureRef = data["profile_photo"] as? String
                let user = User(name: name, email: email, profilePictureRef: profilePictureRef, id: id, balance: balance)
                completion(user)
            }
    }
    
    func updateProfilePhoto(
        email: String,
        completion: @escaping (Bool) -> Void
    ) {
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        
        let photoReference = "profile_pictures/\(path)/photo.png"
        
        let dbRef = database
            .collection("users")
            .document(path)
        
        dbRef.getDocument { snapshot, error in
            guard var data = snapshot?.data(), error == nil else {
                return
            }
            
            data["profile_photo"] = photoReference
            
            dbRef.setData(data) { error in
                completion(error == nil)
            }
        }
    }
}
