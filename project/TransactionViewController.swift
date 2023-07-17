//
//  TransactionViewController.swift
//  project
//
//  Created by Nazar Kopeika on 02.07.2023.
//

import UIKit

class TranscationViewController: UIViewController {
        
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(TransctionTableViewCell.self,
                       forCellReuseIdentifier: TransctionTableViewCell.idenifier)
        return table
    }()
    
//    let dbManager = DBManager()
    let dbManager = DatabaseManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: "background")
        view.backgroundColor = UIColor(named: "background")
        tableView.delegate = self
        tableView.dataSource = self
        
        Accounts.transctions = dbManager.getTransfers() // Replace with your data fetching logic
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}


extension TranscationViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Accounts.transctions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransctionTableViewCell.idenifier, for: indexPath) as! TransctionTableViewCell
        let transcation = Accounts.transctions[indexPath.section]
        
        // Get sender ID
//                let sender = Accounts.users.filter({ $0.id == transcation.sender })[0]
        // Get Receiver Id
//        let receiver = Accounts.customers.filter({ $0.id1 == transcation.receiver })[0]
        let receiver = Accounts.users.reversed().filter({ $0.id == transcation.receiver })[0]
        
        cell.setup(receiver: receiver.name, amount: Int(transcation.amount))
        cell.layer.cornerRadius = 20
        cell.backgroundColor = UIColor(named: "cellbackground")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.isHidden = true
        headerView.backgroundColor = UIColor(named: "background")
        return headerView
    }
}

extension TranscationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
