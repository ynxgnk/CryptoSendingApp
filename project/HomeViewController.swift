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
        setUpRightBarButtonItems()
        setUpHistoryButton()
        tableView.backgroundColor = UIColor(named: "background")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpRightBarButtonItems() {
        let sendButton = UIBarButtonItem(
            title: "Send",
            style: .done,
            target: self,
            action: #selector(didTapSendButton)
        )
        
        let updateButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise"),
            style: .done,
            target: self,
            action: #selector(didTapUpdateButton)
        )
        
        navigationItem.rightBarButtonItems = [updateButton, sendButton]
    }
    
    @objc private func didTapUpdateButton() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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

/*

import UIKit

class HomeViewController: UIViewController {
    
    let email1: String
    let id1: Int64
    var balance1: Int64
    
    init(email1: String, id1: Int64, balance1: Int64) {
        self.email1 = email1
        self.balance1 = balance1
        self.id1 = id1
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpHome(balance: balance1)
    }
    
    private func setUpHome(
        profilePhotoRef: String? = nil,
        name: String? = nil,
        balance: Int64) {
            let headerView = UIView(frame: CGRect(x: 20, y: 50, width: view.width, height: view.width/1.5))
            headerView.backgroundColor = UIColor(named: "background")
            headerView.isUserInteractionEnabled = true
            headerView.clipsToBounds = true
            
            let emailLabel = UILabel()
            emailLabel.frame = CGRect(x: 30, y: 60, width: 100, height: 30)
            emailLabel.text = email1
            
            let balanceLabel = UILabel()
            balanceLabel.frame = CGRect(x: 200, y: 100, width: 80, height: 30)
            balanceLabel.text = "Balance: \(balance)"
            
            let sendButton = UIButton()
            sendButton.setTitle("Transfer", for: .normal)
            sendButton.addTarget(self, action: #selector(didTapTransferButton), for: .touchUpInside)
            sendButton.backgroundColor = .blue
            sendButton.frame = CGRect(x: 200, y: 170, width: 100, height: 40)
        }
    
    @objc private func didTapTransferButton() {
        
        let vc = TransferViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

*/
