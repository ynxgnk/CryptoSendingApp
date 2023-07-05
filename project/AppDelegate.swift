//
//  AppDelegate.swift
//  project
//
//  Created by Nazar Kopeika on 17.06.2023.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        let databaseManager = DatabaseManager.shared
            
            databaseManager.getUsers { users in
                // Handle the retrieved users here
                Accounts.users = users
                print("NUMBER \(users.count)")
            }
        
        
//        let dbManager = DBManager()
//
//        Accounts.customers = dbManager.getUsers()
//        Accounts.transctions = dbManager.getTransfers()
//        
//        if Accounts.customers.isEmpty {
//            dbManager.insertUser(name: "Mohamed Khater", email: "khater@mail.com", balance: 0)
//            dbManager.insertUser(name: "Mohamed Ali", email: "ali@mail.com", balance: 0)
//            dbManager.insertUser(name: "Fady Victor", email: "fady@mail.com", balance: 0)
//            dbManager.insertUser(name: "Ahmed Khater", email: "ahmed@mail.com", balance: 0)
//            dbManager.insertUser(name: "Weal", email: "wael@mail.com", balance: 0)
//            dbManager.insertUser(name: "Mohamed Nabile", email: "nabile@mail.com", balance: 0)
//            dbManager.insertUser(name: "Mohamed Fox", email: "fox@mail.com", balance: 0)
//            dbManager.insertUser(name: "Bassel Mohamed", email: "bassel@mail.com", balance: 0)
//            dbManager.insertUser(name: "Mohamed Ashraf", email: "ashraf@mail.com", balance: 0)
//            dbManager.insertUser(name: "George Adel", email: "george@mail.com", balance: 0)
//
//            Accounts.customers = dbManager.getUsers()

//        }
            return true
        
    }
        
        // MARK: UISceneSession Lifecycle
        
        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        }
        
        func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
            // Called when the user discards a scene session.
            // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
            // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        }
        
        
    
    
}
