//
//  TabBarViewController.swift
//  project
//
//  Created by Nazar Kopeika on 17.06.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpControllers()
    }
    
    private func setUpControllers() {
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "email")
//              let currentId = UserDefaults.standard.string(forKey: "id")
               else {
           
            print("EROROROROR")
            return
        }
        
        let currentBalance = UserDefaults.standard.string(forKey: "balance") ?? "No Balance"
        print("balance: \(currentBalance)")

        
        let currentId = UserDefaults.standard.string(forKey: "id") ?? "Scammed"
        print("currentID: \(currentId)")
        
//        guard let currentId = UserDefaults.standard.string(forKey: "id")
//        else {
//            print("NO CURRENTID")
//            return
//        }

//        print("HERE IT IS !!!!!! "+currentId)

//            DatabaseManager.shared.getUser(email: currentUserEmail, id: currentId) { userID in
//                guard let userID = userID else {
//                    print("ERROR: Failed to fetch user ID from Firebase")
//                    return
//                }

////                print("HERE IT IS !!!!!! " + userID)
        

        
        DispatchQueue.main.async {
            self.tabBar.isTranslucent = true
            self.tabBar.barTintColor = UIColor(named: "background")
        }
        
        let cryptoVC = UINavigationController(rootViewController: CryptoViewController())
//        let newsVC = UINavigationController(rootViewController: NewsViewController())
        let transferVC = UINavigationController(rootViewController: HomeViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController(currentEmail: currentUserEmail, id: currentId, balance: currentBalance))
        
        cryptoVC.tabBarItem.image = UIImage(systemName: "bitcoinsign.circle")
//        newsVC.tabBarItem.image = UIImage(systemName: "house")
        transferVC.tabBarItem.image = UIImage(systemName: "paperplane")
        profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
        
        cryptoVC.navigationItem.largeTitleDisplayMode = .always
        cryptoVC.navigationBar.prefersLargeTitles = true
        
//        newsVC.navigationItem.largeTitleDisplayMode = .always
//        newsVC.navigationBar.prefersLargeTitles = true
        
        transferVC.navigationItem.largeTitleDisplayMode = .always
        transferVC.navigationBar.prefersLargeTitles = true
        
        profileVC.navigationItem.largeTitleDisplayMode = .always
        profileVC.navigationBar.prefersLargeTitles = true
        
        cryptoVC.title = "Crypto Tracker"
//        newsVC.title = "News"
        transferVC.title = "Transfers"
        profileVC.title = "Profile"
        
        setViewControllers([cryptoVC, transferVC, profileVC], animated: true)
    }
}
