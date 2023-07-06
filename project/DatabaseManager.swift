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

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Firestore.firestore()
    
    private init() {}
    
    public func insert(
        user: User,
        completion: @escaping (Bool) -> Void
    ) {
        let documentId = user.email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        let data = [
            "email": user.email,
            "name": user.name,
            "id": user.id,
            "balance": user.balance
        ] as [String : Any]
        
        database
            .collection("users")
            .document(documentId)
            .setData(data) { error in
                completion(error == nil)
            }
    }
    
    public func getUsers(completion: @escaping ([User]) -> Void) {
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
                       let id = data["id"] as? String,
                       let balance = data["balance"] as? String {
                        let ref = data["profile_photo"] as? String
                        let user = User(name: name, email: email, profilePictureRef: ref, id: id, balance: balance)
                        users.append(user)
                    }
                }
                
                completion(users)
            }
    }
    
    public func getUser(
        email: String,
        id: String, //tyt
        completion: @escaping (User?) -> Void
    ) {
        let documentId = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        database
            .collection("users")
            .document(documentId)
            .getDocument { snapshot, error in
                guard let data = snapshot?.data() as? [String: String],
                      let name = data["name"],
                      let id = data["id"],
                      let balance = data["balance"],
                      error == nil else {
                    return
                }
                
                var ref = data["profile_photo"]
                let user = User(name: name, email: email, profilePictureRef: ref, id: id, balance: balance)
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
