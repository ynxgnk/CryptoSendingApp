//
//  LastTransactionViewController.swift
//  project
//
//  Created by Nazar Kopeika on 29.07.2023.
//

/*

import UIKit
import FirebaseFirestore 

class LastTransactionViewController: UIViewController {
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(LastTransactionTableViewCell.self,
                       forCellReuseIdentifier: LastTransactionTableViewCell.identifier)
        return table
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: view.frame.size.height)
    }
    
//    override func viewDidLoad() { //вуафгде
//        super.viewDidLoad()
//        view.addSubview(tableView)
//        tableView.backgroundColor = UIColor(named: "background")
//        tableView.delegate = self
//        tableView.dataSource = self
//        view.backgroundColor = UIColor(named: "background")
//    }
    
    private var lastTransaction: Transction? // Add a property to store the last transaction
    let dbManager = DatabaseManager()

    override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(tableView)
            tableView.backgroundColor = UIColor(named: "background")
//            tableView.delegate = self
//            tableView.dataSource = self
            view.backgroundColor = UIColor(named: "background")

            // Fetch transactions from the database and reload table view data
            fetchTransactions()
        }
    
    private func fetchTransactions() {
            dbManager.getTransfers { [weak self] transfers, error in
                if let error = error {
                    // Handle the error here, if needed
                    print("Error fetching transfers: \(error.localizedDescription)")
                } else {
                    // Use the fetched transfers here
                    Accounts.transctions = transfers ?? []
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }



//extension LastTransactionViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        Accounts.transctions.count
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        1
//    }
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: LastTransactionTableViewCell.identifier, for: indexPath) as? LastTransactionTableViewCell else {
////            fatalError()
////        }
////        let transcation = Accounts.transctions[indexPath.section]
////        let receiver = Accounts.users.reversed().filter({ $0.email == transcation.receiver })[0] //default receiver
////        let sender = Accounts.users.reversed().filter({ $0.email == transcation.sender })[0] //default receiver
////
////        cell.setup(receiver: receiver, sender: sender, amount: Int64(transcation.amount))
////        return cell
////    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: LastTransactionTableViewCell.identifier, for: indexPath) as? LastTransactionTableViewCell else {
//                fatalError()
//            }
//
//            let transaction = Accounts.transctions[indexPath.row]
//            cell.setup(transaction: transaction)
//
//            return cell
//        }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        100
//    }
//}

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: LastTransactionTableViewCell.identifier, for: indexPath) as? LastTransactionTableViewCell else {
//            fatalError()
//        }
//        let transcation = Accounts.transctions[indexPath.row]
//
//        let receiverEmail = transcation.receiver
//        let senderEmail = transcation.sender
//
//        let receiver = Accounts.users.first { $0.email == receiverEmail }
//        let sender = Accounts.users.first { $0.email == senderEmail }
//
//        if let receiver = receiver, let sender = sender {
//            cell.setup(receiverName: receiver.name, senderName: sender.name, amount: transcation.amount)
//        } else {
//            cell.setup(receiverName: "Not Found", senderName: "Not Found", amount: transcation.amount)
//        }
//        return cell
//    }
//}

*/
