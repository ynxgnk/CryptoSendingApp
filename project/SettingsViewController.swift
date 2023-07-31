//
//  SettingsViewController.swift
//  project
//
//  Created by Nazar Kopeika on 21.06.2023.
//

import StoreKit
import SafariServices
import UIKit

class SettingsViewController: UIViewController {
    
    private let settingsTable: UITableView = {
        let table = UITableView()
        table.register(SettingsTableViewCell.self,
                       forCellReuseIdentifier: SettingsTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(settingsTable)
        settingsTable.backgroundColor = UIColor(named: "background")
        settingsTable.isScrollEnabled = false
        settingsTable.delegate = self
        settingsTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        settingsTable.frame = CGRect(
            x: 0,
            y: 50,
            width: view.frame.size.width,
            height: 600
        )
        
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
            fatalError()
        }
        
        if indexPath.section == 0 {
            cell.settingsName.text = "Rate App"
            cell.settingsImage.image = UIImage(systemName: "star")
        } else if indexPath.section == 1 {
            cell.settingsName.text = "Source Code"
            cell.settingsImage.image = UIImage(systemName: "gear")
        } else if indexPath.section == 2 {
            cell.settingsName.text = "Contact Us"
            cell.settingsImage.image = UIImage(systemName: "paperplane")
        }
        
        cell.layer.cornerRadius = 22
        cell.backgroundColor = UIColor(named: "cellbackground")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let alert = UIAlertController(title: "Feedback",
                                          message: "Are you enjoying the app?",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes, I love it",
                                          style: .default, handler: { [weak self] _ in
                guard let scene = self?.view.window?.windowScene else {
                    print("no scene")
                    return
                }
                SKStoreReviewController.requestReview(in: scene)
            }))
            
            alert.addAction(UIAlertAction(title: "No, this sucks!",
                                          style: .default, handler: { _ in
                UIApplication.shared.open(URL(string: "https://www.instagram.com/ynxgnk/")!)
            }))
            
            present(alert, animated: true)
        }
        
        if indexPath.section == 1 {
            guard let url = URL(string: "https://github.com/ynxgnk/CryptoSendingApp/tree/main") else {
                return
            }
            
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
        
        if indexPath.section == 2 {
            guard let url = URL(string: "https://www.instagram.com/ynxgnk/") else {
                return
            }
            
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        
        return footerView
    }
    
}
