//
//  TransferViewController.swift
//
//
//  Created by Nazar Kopeika on 02.07.2023.
//

import UIKit

class TransferViewController: UIViewController {

    private var receiverLabel: UITextField = {
        let field = UITextField()
        field.placeholder = " Receiver"
        field.textColor = .white
        field.layer.cornerRadius = 8
        return field
    }()

    private var amountLabel: UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 8
        field.textColor = .white
        field.placeholder = " Amount"
        return field
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Send", for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var currentUserID: Int64 = 0
    var dbManager = DatabaseManager()
    var receiverPickerView = UIPickerView()
    var selectedReceiver: User?
    var latestTransactionId: Int64 = 0
    
    let senderEmail = UserDefaults.standard.string(forKey: "email")?
        .replacingOccurrences(of: ".", with: "_")
        .replacingOccurrences(of: "@", with: "_")
    
    var filteredUsers: [User] = [] // Array to store filtered users

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLatestTransactionId()

        view.addSubview(receiverLabel)
        view.addSubview(amountLabel)
        view.addSubview(sendButton)
        view.backgroundColor = UIColor(named: "background")

        receiverPickerView.delegate = self
        receiverPickerView.dataSource = self

        receiverLabel.inputView = receiverPickerView
        
        if let currentID = UserDefaults.standard.string(forKey: "id"), let id = Int64(currentID) {
            currentUserID = id
        }
        
        // Populate filteredUsers array by excluding the current user
        filteredUsers = Accounts.users.filter { $0.id != currentUserID }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        receiverLabel.frame = CGRect(x: 50, y: 220, width: 300, height: 50)
        receiverLabel.backgroundColor = UIColor(named: "cellbackground")
        
        amountLabel.frame = CGRect(x: 50, y: 290, width: 300, height: 50)
        amountLabel.backgroundColor = UIColor(named: "cellbackground")
        
        sendButton.frame = CGRect(x: 125, y: 400, width: 150, height: 50)
    }
    
    private func fetchLatestTransactionId() {
        dbManager.getTransfers { [weak self] transfers, error in
            guard let transfers = transfers else {
                return
            }
            
            // Find the maximum transaction ID among the existing transactions
            let maxId = transfers.reduce(0) { max($0, $1.id) }
            
            // Set the latestTransactionId to the next available ID
            self?.latestTransactionId = maxId + 1
        }
    }
    
    @objc private func sendButtonPressed(_ sender: UIButton) {
        guard let receiver = receiverLabel.text, !receiver.isEmpty,
              let sender = senderEmail,
              let amount = amountLabel.text, !amount.isEmpty
        else {
            let alert = UIAlertController(title: "Woops", message: "Please fill all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        print("Amount: \(amount)")
        
        if let selectedReceiver = selectedReceiver {
            let selectedReceiverId = selectedReceiver.email
                .replacingOccurrences(of: ".", with: "_")
                .replacingOccurrences(of: "@", with: "_")
            dbManager.transferMoney(from: senderEmail ?? "", to: selectedReceiverId, amount: Int64(amount) ?? 0, id: latestTransactionId) { [weak self] error in
                self?.latestTransactionId += 1
                
                if let error = error {
                    let alert = UIAlertController(title: "Failed!", message: "Cannot transfer \(amount)$ from \(sender) to \(receiver)!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                        self?.didTapOk()
                    }))
                    self?.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Success!", message: "Transferred \(amount)$ from \(sender) to \(receiver)!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                        self?.didTapOk()
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    func didTapOk() {
        // Dismiss the current view controller
        self.dismiss(animated: true) {
            // After dismissal, present HomeViewController from the root view controller
            if let keyWindow = UIApplication.shared.keyWindow,
              let _ = keyWindow.rootViewController {
            }
        }
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// MARK: - UIPickerView DataSource & Delegate
extension TransferViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filteredUsers.count // Use the filtered users count instead
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filteredUsers[row].name // Use the filtered users
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == receiverPickerView {
            selectedReceiver = filteredUsers[safe: row]
            receiverLabel.text = selectedReceiver?.name
        }
        view.endEditing(true)
    }
}
