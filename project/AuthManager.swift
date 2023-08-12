//
//  Auth.swift
//  project
//
//  Created by Nazar Kopeika on 20.06.2023.
//

import Foundation
import FBSDKLoginKit
import FirebaseAuth

final class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private init() {}
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    public func signUp(
        email: String,
        password: String,
        id: String,
        completion: @escaping (Bool) -> Void
    ) {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6,
              !id.trimmingCharacters(in: .whitespaces).isEmpty,
              id.count <= 3 else {
            return
        }
        
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            
            //Account Created
            completion(true)
        }
    }
    
    public func signIn(
        email: String,
        password: String,
        completion: @escaping (Bool) -> Void
    ) {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {
            return
        }
        
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    public func signOut(
        completion: (Bool) -> Void
    ) {
        do {
            try auth.signOut()
            completion(true)
        }
        catch {
            print(error)
            completion(false)
        }
    }
    
    func facebookSignIn(name: String, email: String, password: String, completion: @escaping (Bool) -> Void) { //tyt
            // Проведите аутентификацию пользователя с использованием Facebook
            // Это может включать в себя создание учетной записи в Firebase и сохранение дополнительных данных пользователя в базе данных
            
            // Пример:
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard error == nil, let uid = authResult?.user.uid else {
                    completion(false)
                    return
                }

                // Создание записи пользователя в базе данных
            let user = User(name: name, email: email, profilePictureRef: nil, id: Int64(uid) ?? 0, balance: 0)
                DatabaseManager.shared.insert(user: user) { success in
                    completion(success)
                }
            }
        }
}
