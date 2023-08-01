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
    
    let dbManager = DatabaseManager()
    private var transactions: [Transction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: "background")
        view.backgroundColor = UIColor(named: "background")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        
        fetchTransactions()
        tableView.reloadData()
    }
    
    private func fetchTransactions() { //default
        dbManager.getTransfers { [weak self] (transfers, error) in
            guard let self = self else { return }

            if let error = error {
                // Handle the error if needed
                print("Error fetching transactions: \(error)")
            } else {
                // Update the data source, sort transactions, and reload the table view
                self.transactions = transfers?.sorted(by: { $0.id > $1.id }) ?? []
                self.tableView.reloadData()
            }
        }
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
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransctionTableViewCell.idenifier, for: indexPath) as! TransctionTableViewCell
        let transcation = transactions[indexPath.section]

        // Get sender ID
        // Get Receiver Id
        if let receiver = Accounts.users.first(where: { String($0.id) == transcation.receiver }),
           let sender = Accounts.users.first(where: { String($0.id) == transcation.sender }) {
            cell.setup(id: transcation.id, sender: sender.name, receiver: receiver.name, amount: Int(transcation.amount))
        } else {
            // Handle the case where there is no matching receiver
            cell.setup(id: transcation.id, sender: transcation.sender ?? "Unknown", receiver: transcation.receiver, amount: Int(transcation.amount))
        }

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
