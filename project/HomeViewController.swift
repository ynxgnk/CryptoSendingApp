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

    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navigationController?.navigationBar.backgroundColor = UIColor(named: "background")
        view.backgroundColor = UIColor(named: "background")
        setUpRightBarButtonItems()
        tableView.backgroundColor = UIColor(named: "background")
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setUpRightBarButtonItems() {
        let updateButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise"),
            style: .done,
            target: self,
            action: #selector(didTapUpdateButton)
        )

        navigationItem.rightBarButtonItems = [updateButton]
    }

    @objc private func didTapUpdateButton() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: 300)
        tableView.isScrollEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.reloadData()
    }
}

// MARK: - UITableView DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomerTableViewCell.identifier, for: indexPath) as? CustomerTableViewCell else {
            fatalError()
        }

        cell.layer.cornerRadius = 10
        cell.delegate = self
        
        if let currentUser = currentUser {
            cell.setup(user: currentUser)
        }

        cell.backgroundColor = UIColor(named: "cellbackground")
        return cell
    }
    
}

// MARK: - UITableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension HomeViewController: CustomerTableViewCellDelegate {
    func didTapSendButton(in cell: CustomerTableViewCell) {
        let vc = TransferViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    func didTapHistoryButton(in cell: CustomerTableViewCell) {
        let vc = TranscationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
