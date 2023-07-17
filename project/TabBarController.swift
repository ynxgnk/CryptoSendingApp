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
//              let currentID = UserDefaults.standard.string(forKey: "id")
        else {
            print("EROROROROR")
            return
        }
        
//        let currentUserEmail = UserDefaults.standard.string(forKey: "email") ?? "No email"

        let currentBalance = UserDefaults.standard.integer(forKey: "balance")
        print("balance: \(currentBalance)")
        
        let currentID = UserDefaults.standard.integer(forKey: "id")
        print("id: \(currentID)")
            
            DispatchQueue.main.async {
                self.tabBar.isTranslucent = true
                self.tabBar.barTintColor = UIColor(named: "background")
            }
            
            let cryptoVC = UINavigationController(rootViewController: CryptoViewController())
            let transferVC = UINavigationController(rootViewController: HomeViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController(currentEmail: currentUserEmail, id: Int64(currentID) ?? 0, balance: Int64(currentBalance)))
            
            cryptoVC.tabBarItem.image = UIImage(systemName: "bitcoinsign.circle")
            transferVC.tabBarItem.image = UIImage(systemName: "paperplane")
            profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
            
            cryptoVC.navigationItem.largeTitleDisplayMode = .always
            cryptoVC.navigationBar.prefersLargeTitles = true
            
            transferVC.navigationItem.largeTitleDisplayMode = .always
            transferVC.navigationBar.prefersLargeTitles = true
            
            profileVC.navigationItem.largeTitleDisplayMode = .always
            profileVC.navigationBar.prefersLargeTitles = true
            
            cryptoVC.title = "Crypto Tracker"
            transferVC.title = "Transfers"
            profileVC.title = "Profile"
            
            setViewControllers([cryptoVC, transferVC, profileVC], animated: true)
        }
    }
