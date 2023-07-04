//
//  SettingsViewController.swift
//  project
//
//  Created by Nazar Kopeika on 21.06.2023.
//

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
             fatalError()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
}
