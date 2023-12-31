//
//  TransactionTableViewCell.swift
//  project
//
//  Created by Nazar Kopeika on 02.07.2023.
//

import UIKit

class `TransctionTableViewCell`: UITableViewCell {
    static let idenifier = "TransctionTableViewCell"
    
    private var currentUserEmail: String?
    private var currentUserId: Int64?
    
    private let receiverLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let senderLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let idLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let amountLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(receiverLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(senderLabel)
        contentView.addSubview(idLabel)
        
        currentUserEmail = UserDefaults.standard.string(forKey: "email")?
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        receiverLabel.frame = CGRect(
            x: 10,
            y: 65,
            width: 300,
            height: 25
        )

        senderLabel.frame = CGRect(
            x: 10,
            y: 35,
            width: 300,
            height: 25
        )

        idLabel.frame = CGRect(
            x: 10,
            y: 5,
            width: 150,
            height: 25
        )

        amountLabel.frame = CGRect(
            x: 300,
            y: 65,
            width: 80,
            height: 25
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        amountLabel.text = nil
        receiverLabel.text = nil
        senderLabel.text = nil
        idLabel.text = nil
    }
    
    func setup(id: Int64, sender: String, receiver: String, amount: Int, currentUserId: Int64) {
            self.currentUserId = currentUserId

            let amountText: String

            if sender == currentUserEmail {
                amountText = "-\(amount)$"
                senderLabel.text = "Receiver: \(receiver)"
            } else {
                senderLabel.text = "Sender: \(sender)"
                amountText = "+\(amount)$"
            }
            amountLabel.text = amountText
        
        idLabel.text = "Transaction ID: \(id)"
    }
}
