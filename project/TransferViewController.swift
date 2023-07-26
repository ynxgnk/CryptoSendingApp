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
    
    var dbManager = DatabaseManager()
    var pickerView = UIPickerView()
    var selectedReceiver: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(receiverLabel)
        view.addSubview(amountLabel)
        view.addSubview(sendButton)
        view.backgroundColor = UIColor(named: "background")
        pickerView.delegate = self
        pickerView.dataSource = self
        receiverLabel.inputView = pickerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        receiverLabel.frame = CGRect(x: 50, y: 150, width: 300, height: 50)
        receiverLabel.backgroundColor = UIColor(named: "cellbackground")
        
        amountLabel.frame = CGRect(x: 50, y: 220, width: 300, height: 50)
        amountLabel.backgroundColor = UIColor(named: "cellbackground")
        
        sendButton.frame = CGRect(x: 125, y: 400, width: 150, height: 50)
    }
    
    
    @objc private func sendButtonPressed(_ sender: UIButton) {
        guard let receiver = receiverLabel.text, !receiver.isEmpty,
              let amount = amountLabel.text, !amount.isEmpty
        else {
            let alert = UIAlertController(title: "Woops", message: "Please fill all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        print("Amount: \(amount)")
        if let selectedReceiver = selectedReceiver {
            let selected = selectedReceiver.email
                .replacingOccurrences(of: ".", with: "_")
                .replacingOccurrences(of: "@", with: "_")
            dbManager.transferMoney(to: selected, amount: Int64(amount) ?? 0) { [weak self] error in
                guard let self = self else { return }

                if let error = error {
                    let alert = UIAlertController(title: "Woops", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                self.dbManager.getUsers { users, error in
                    if let error = error {
                        // Handle the error here, if needed
                        print("ERROR1 fetching users: \(error.localizedDescription)")
                    } else {
                        // Use the fetched users here
                        Accounts.users = users
                    }
                }
                self.dbManager.getTransfers { transfers, error in
                    if let error = error {
                        // Handle the error here, if needed
                        print("Error fetching transfers ERROR3: \(error.localizedDescription)")
                    } else {
                        // Use the fetched transfers here
                        if let transfers = transfers {
                            Accounts.transctions = transfers
                        } else {
                            print("No transfers found. ERROR2")
                        }
                    }
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
}


// MARK: - UIPickerView DataSource
extension TransferViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Accounts.users.count
    }
}


// MARK: - UIPickerView Delegate
extension TransferViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Accounts.users[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        view.endEditing(true)
        selectedReceiver = Accounts.users[row]
        receiverLabel.text = Accounts.users[row].name
    }
}
