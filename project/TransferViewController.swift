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
    
    private var senderLabel: UITextField = {
        let field = UITextField()
        field.placeholder = " Sender"
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
    
    var dbManager = DatabaseManager()
    var receiverPickerView = UIPickerView()
    var senderPickerView = UIPickerView()
    var selectedReceiver: User?
    var selectedSender: User?
    var latestTransactionId: Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLatestTransactionId()
        
        view.addSubview(receiverLabel)
        view.addSubview(senderLabel)
        view.addSubview(amountLabel)
        view.addSubview(sendButton)
        view.backgroundColor = UIColor(named: "background")
        
        receiverPickerView.delegate = self
        receiverPickerView.dataSource = self
        
        senderPickerView.delegate = self
        senderPickerView.dataSource = self
        
        receiverLabel.inputView = receiverPickerView
        senderLabel.inputView = senderPickerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        senderLabel.frame = CGRect(x: 50, y: 150, width: 300, height: 50)
        senderLabel.backgroundColor = UIColor(named: "cellbackground")
        
        receiverLabel.frame = CGRect(x: 50, y: 220, width: 300, height: 50)
        receiverLabel.backgroundColor = UIColor(named: "cellbackground")
        
        amountLabel.frame = CGRect(x: 50, y: 290, width: 300, height: 50)
        amountLabel.backgroundColor = UIColor(named: "cellbackground")
        
        sendButton.frame = CGRect(x: 125, y: 400, width: 150, height: 50)
    }
    
    private func fetchLatestTransactionId() {
        dbManager.getTransfers { [weak self] transfers, error in
            guard let transfers = transfers else {
                // Handle the error here, if needed
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
              let sender = senderLabel.text, !sender.isEmpty,
              let amount = amountLabel.text, !amount.isEmpty
        else {
            let alert = UIAlertController(title: "Woops", message: "Please fill all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        print("Amount: \(amount)")
        
        if let selectedReceiver = selectedReceiver, let selectedSender = selectedSender {
            let selectedReceiverId = selectedReceiver.email
                .replacingOccurrences(of: ".", with: "_")
                .replacingOccurrences(of: "@", with: "_")
            let selectedSenderId = selectedSender.email
                .replacingOccurrences(of: ".", with: "_")
                .replacingOccurrences(of: "@", with: "_")
            dbManager.transferMoney(from: selectedSenderId, to: selectedReceiverId, amount: Int64(amount) ?? 0, id: latestTransactionId) { [weak self] error in
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
               let rootViewController = keyWindow.rootViewController {
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
        return Accounts.users.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Accounts.users[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == receiverPickerView {
            selectedReceiver = Accounts.users[safe: row]
            receiverLabel.text = selectedReceiver?.name
        } else if pickerView == senderPickerView {
            selectedSender = Accounts.users[safe: row]
            senderLabel.text = selectedSender?.name
        }
        view.endEditing(true)
    }
}
