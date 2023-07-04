//
//  TransferViewController.swift
//  
//
//  Created by Nazar Kopeika on 02.07.2023.
//

import UIKit

class TransferViewController: UIViewController {
    
//    @IBOutlet weak var receiverLabel: UITextField!
//    @IBOutlet weak var amountLabel: UITextField!
    
    private var receiverLabel: UITextField = {
        let field = UITextField()
        field.placeholder = " Receiver"
        field.layer.cornerRadius = 8
        return field
    }()
    
    private var amountLabel: UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 8
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
    
    let dbManager = DBManager()
    var pickerView = UIPickerView()
    var selectedReceiver: Customer? //tyt Customer
    
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
        receiverLabel.backgroundColor = .brown
        
        amountLabel.frame = CGRect(x: 50, y: 220, width: 300, height: 50)
        amountLabel.backgroundColor = .orange
        
        sendButton.frame = CGRect(x: 125, y: 400, width: 150, height: 50)
//        sendButton.backgroundColor = .red
    }
    
    
    @objc private func sendButtonPressed(_ sender: UIButton) {
        guard let receiver = receiverLabel.text, !receiver.isEmpty,
              let amount = amountLabel.text, !amount.isEmpty
        else {
            let alert = UIAlertController(title: "Woops", message: "Please fill all fileds", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        if let selectedReceiver = selectedReceiver {
            dbManager.transferMoney(to: selectedReceiver.id, amount: Int64(amount)!) { [weak self] error in
                guard let self = self else { return }
                
                if let error = error {
                    let alert = UIAlertController(title: "Woops", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }

                Accounts.customers = self.dbManager.getUsers()
                Accounts.transctions = self.dbManager.getTransfers()
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
        return Accounts.customers.count
    }
}


// MARK: - UIPickerView Delegate
extension TransferViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Accounts.customers[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        view.endEditing(true)
        selectedReceiver = Accounts.customers[row]
        receiverLabel.text = Accounts.customers[row].name
    }
}
