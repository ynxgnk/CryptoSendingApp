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
    private var currentUserId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: "background")
        view.backgroundColor = UIColor(named: "background")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        let currentIDString = UserDefaults.standard.string(forKey: "email")
        currentUserId = currentIDString?
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_") ?? "No Email"
            
            print("Current User ID1: \(currentUserId)")
        
        fetchTransactions()
        tableView.reloadData()
    }
    
    private func fetchTransactions() {
        dbManager.getTransfers { [weak self] (transfers, error) in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching transactions: \(error)")
            } else {
                self.transactions = transfers?
                    .filter {
                        $0.sender == String(self.currentUserId) || $0.receiver == String(self.currentUserId)
                    }
                    .sorted(by: { $0.id > $1.id })
                ?? []
                
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

        // Pass the currentUserId to the cell setup
        cell.setup(id: transcation.id, sender: transcation.sender ?? "No Sender", receiver: transcation.receiver, amount: Int(transcation.amount), currentUserId: Int64(currentUserId) ?? 0)

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

