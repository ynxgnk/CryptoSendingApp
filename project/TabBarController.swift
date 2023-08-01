//
//  TabBarViewController.swift
//  project
//
//  Created by Nazar Kopeika on 17.06.2023.
//

/*

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpControllers()
    }
    
    private func setUpControllers() {
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "email"),
              let currentID = UserDefaults.standard.string(forKey: "id")
                //              let currentBalance = UserDefaults.standard.string(forKey: "balance")
        else {
            print("EROROROROR")
            return
        }

        let currentBalance = UserDefaults.standard.integer(forKey: "balance")
        
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

*/

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpControllers()
    }

    private func setUpControllers() {
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "email"),
              let currentID = UserDefaults.standard.string(forKey: "id")
        else {
            print("Error: Current user data not available.")
            return
        }
        
        let currentBalance = UserDefaults.standard.integer(forKey: "balance")
        let currentProfilePictureRef = UserDefaults.standard.string(forKey: "profilePictureRef")
        let currentName = UserDefaults.standard.string(forKey: "name") ?? "no"

        let currentBalanceValue = Int64(currentBalance) ?? 0

        DispatchQueue.main.async {
            self.tabBar.isTranslucent = true
            self.tabBar.barTintColor = UIColor(named: "background")
        }

        // Create the current user object
        let currentUser = User(
            name: currentName, email: currentUserEmail,
            profilePictureRef: currentProfilePictureRef, id: Int64(currentID) ?? 0,
            balance: currentBalanceValue
        )

        // Set up view controllers
        let cryptoVC = UINavigationController(rootViewController: CryptoViewController())
        let transferVC = UINavigationController(rootViewController: HomeViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController(currentEmail: currentUserEmail, id: Int64(currentID) ?? 0, balance: Int64(currentBalance) ?? 0))

        // Pass the current user object to HomeViewController
        if let homeVC = transferVC.viewControllers.first as? HomeViewController {
            homeVC.currentUser = currentUser
        }

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

