//
//  HomeViewController.swift
//  project
//
//  Created by Nazar Kopeika on 02.07.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomerTableViewCell.self,
                       forCellReuseIdentifier: CustomerTableViewCell.identifier)
        return table
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navigationController?.navigationBar.backgroundColor = UIColor(named: "background")
        view.backgroundColor = UIColor(named: "background")
        setUpSendButton()
        
        setUpHistoryButton()
        tableView.backgroundColor = UIColor(named: "background")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpSendButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Send",
            style: .done,
            target: self,
            action: #selector(didTapSendButton)
        )
    }
    
    @objc private func didTapSendButton() {
        
        let vc = TransferViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUpHistoryButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "History",
            style: .done,
            target: self,
            action: #selector(didTapHistoryButton)
        )
    }
    
    @objc private func didTapHistoryButton() {
        
        let vc = TranscationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) { //default
            super.viewWillAppear(animated)
            navigationController?.navigationBar.prefersLargeTitles = true
            tableView.reloadData()
        }
}

// MARK: - UITableView DataSource
extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Accounts.users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomerTableViewCell.identifier, for: indexPath) as? CustomerTableViewCell else {
            fatalError()
        }
        cell.setup(user: Accounts.users[indexPath.row])
        print("Number of accounts \(Accounts.users.count)")
        cell.backgroundColor = UIColor(named: "cellbackground")
        return cell
    }
}


// MARK: - UITableView Delegate
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //default
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
