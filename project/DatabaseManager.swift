//
//  DatabaseManager.swift
//  project
//
//  Created by Nazar Kopeika on 20.06.2023.
//

import Foundation
import SQLite
import FirebaseFirestore
import FirebaseDatabase

enum Tables: String {
    case transfers = "transfers"
    case users = "users"
}

class DatabaseManager {
    private var db: Connection!
    static let shared = DatabaseManager()
    private let database = Firestore.firestore()
    
    init(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentDirectory.appendingPathComponent("db1").appendingPathExtension("sqlite2") // bez 1 i 3
            let db = try Connection(fileURL.path)
            self.db = db
            
            
            // Create Tables if there is no tables
            createUserTable()
            createTransferTable()
            
        } catch {
            print(error)
        }
    }

    public func transferMoney(from senderId: Int64, to receiverId: Int64, amount: Int64, compeletion: (Error?) -> Void){
        do {
            let sender = try db.prepare("SELECT balance FROM users WHERE id = \(senderId)")
            let recevier = try db.prepare("SELECT balance FROM users WHERE id = \(receiverId)")
            
            var senderBalance: Int64 = 0
            for element in sender {
                senderBalance = element[0] as! Int64
            }
            
            var receiverBalance: Int64 = 0
            for element in recevier{
                receiverBalance = element[0] as! Int64
            }
            
            let newSenderBalance = senderBalance - amount
            let newReceiverBalance = receiverBalance + amount
            
            if newSenderBalance < 0 {
                compeletion(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Transfer can't be done because you don't have enough balance."]))
                return
            }
            
            addNewTransferRecord(sender: senderId, receiver: receiverId, amount: amount)
            
            _ = try db.run("UPDATE users SET balance = \(newSenderBalance) WHERE id = \(senderId)")
            _ = try db.run("UPDATE users SET balance = \(newReceiverBalance) WHERE id = \(receiverId)")
            
            compeletion(nil)
            
        } catch {
            compeletion(error)
        }
    }
    
    public func transferMoney(to receiverId: Int64, amount: Int64, compeletion: (Error?) -> Void){
        do {
            let recevier = try db.prepare("SELECT balance FROM users WHERE id = \(receiverId)")
            
            var receiverBalance: Int64 = 0
            for element in recevier{
                receiverBalance = element[0] as! Int64
            }
            
            let newReceiverBalance = receiverBalance + amount
            
            addNewTransferRecord(receiver: receiverId, amount: amount)
            
            _ = try db.run("UPDATE users SET balance = \(newReceiverBalance) WHERE id = \(receiverId)")
            
            compeletion(nil)
            
        } catch {
            compeletion(error)
        }
    }
    
    private func addNewTransferRecord(sender: Int64? = nil, receiver: Int64, amount: Int64){
        do {
            if let sender = sender {
                let stmt = try db.prepare("INSERT INTO transfers (senderId, receiverId, amount) VALUES (?, ?, ?)")
                try stmt.run([sender, receiver, amount])
                
            }else{
                let stmt = try db.prepare("INSERT INTO transfers (receiverId, amount) VALUES (?, ?)")
                try stmt.run([receiver, amount])
            }
            
        } catch {
            print(error)
        }
    }
    
    public func getUsersTransfers() -> [User]{ // Customer
        //        var users: [Customer] = []
        var users: [User] = []
        
        do {
            let stmt = try db.prepare("SELECT * FROM users")
            
            for element in stmt{
                let id = element[0] as! Int64
                let name = element[1] as! String
                let email = element[2] as! String
                let balance = element[3] as! Int64
                
                //                let user = Customer(id1: id, name: name, email: email, balance: balance)
                let user = User(name: name, email: email, profilePictureRef: nil, id: id, balance: balance)
                users.append(user)
            }
            
        } catch {
            print(error)
        }
        return users
    }
    
//    public func insert(
//        user: User,
//        completion: @escaping (Bool) -> Void
//    ) {
//        let documentId = user.email
//            .replacingOccurrences(of: ".", with: "_")
//            .replacingOccurrences(of: "@", with: "_")
//
//        let data = [
//            "email": user.email,
//            "name": user.name,
//            "id": user.id,
//            "balance": user.balance
//        ] as [String : Any]
//
//        database
//            .collection("users")
//            .document(documentId)
//            .setData(data) { error in
//                completion(error == nil)
//            }
//    }
    
    func insert(user: User, completion: @escaping (Bool) -> Void) {
            database.collection("users").document("\(user.id)").setData([
                "name": user.name,
                "email": user.email,
                "profilePictureRef": user.profilePictureRef ?? "",
                "balance": user.balance
            ]) { error in
                if let error = error {
                    print("Failed to insert user: \(error)")
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }

    
    public func getTransfers() -> [Transction]{ 
        var transfers: [Transction] = []
        do {
            let stmt = try db.prepare("SELECT * FROM transfers")

            for element in stmt{
                let id = element[0] as! Int64
                let sender = element[1] as? Int64
                let receiver = element[2] as! Int64
                let amount = element[3] as! Int64
                
                let transfer = Transction(id: id, sender: sender, receiver: receiver, amount: amount)
                transfers.append(transfer)
            }
            
        } catch {
            print(error)
        }
        
        return transfers
    }
    
    public func getUsers1(completion: @escaping ([User]) -> Void) {
        database
            .collection("users")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    completion([])
                    return
                }

                var users: [User] = []

                for document in documents {
                    if let data = document.data() as? [String: Any],
                       let email = data["email"] as? String,
                       let name = data["name"] as? String,
                       let id = data["id"] as? Int64,
                       let balance = data["balance"] as? Int64 {
                        let ref = data["profile_photo"] as? String
                        let user = User(name: name, email: email, profilePictureRef: ref, id: id, balance: balance)
                        users.append(user)
                    }
                }

                completion(users)
            }
    }
    
//    public func getUsers1() -> [User]{
//           var users: [User] = []
//
//           do {
//               let stmt = try db.prepare("SELECT * FROM users")
//
//               for element in stmt{
//                   let id = element[0] as! Int64
//                   let name = element[1] as! String
//                   let email = element[2] as! String
//                   let balance = element[3] as! Int64
//
//                   let user = User(name: name, email: email, profilePictureRef: nil, id: id, balance: balance)
//                   users.append(user)
//               }
//
//           } catch {
//               print(error)
//           }
//           return users
//       }
    
    public func getUser(email: String, id: Int64, completion: @escaping (User?) -> Void) { 
        let documentId = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        database
            .collection("users")
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

extension DatabaseManager {
    private func createUserTable(){
        let users1 = Table("users") // bez 1
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let email = Expression<String>("email")
        let balance1 = Expression<Int>("balance")
        
        do {
            try db.run(users1.create{ table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(email, unique: true)
                table.column(balance1)
            })
        } catch {
            print(error)
        }
    }
    
    private func createTransferTable() {
        let transfers1 = Table("transfers") // bez 1
        let id = Expression<Int>("id")
        let senderId = Expression<Int?>("senderId")
        let receiverId = Expression<Int>("receiverId")
        let amount = Expression<Int>("amount")
        
        do {
            try db.run(transfers1.create{ table in
                table.column(id, primaryKey: true)
                table.column(senderId)
                table.column(receiverId)
                table.column(amount)
            })
        } catch {
            print(error)
        }
    }
    
    func insertUser(name: String, email: String, balance: Int){
        do {
            let stmt = try db.prepare("INSERT INTO users (name, email, balance) VALUES (?, ?, ?)")
            try stmt.run([name, email, balance])
            
        } catch {
            print(error)
        }
    }
}
