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
           
            print("ERRROROROR")
            return
        }
        
        let currentId = UserDefaults.standard.string(forKey: "id") ?? "NO ID"
        print(currentId)

        
        DispatchQueue.main.async {
            self.tabBar.isTranslucent = true
            self.tabBar.barTintColor = UIColor(named: "background")
        }
        
        let cryptoVC = UINavigationController(rootViewController: CryptoViewController())
//        let newsVC = UINavigationController(rootViewController: NewsViewController())
        let transferVC = UINavigationController(rootViewController: HomeViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController(currentEmail: currentUserEmail, id: currentId))
        
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
