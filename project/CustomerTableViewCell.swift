//
//  CustomerTableViewCell.swift
//  project
//
//  Created by Nazar Kopeika on 02.07.2023.
//

import UIKit

protocol CustomerTableViewCellDelegate: AnyObject {
    func didTapSendButton(in cell: CustomerTableViewCell)
    func didTapHistoryButton(in cell: CustomerTableViewCell)
}

class CustomerTableViewCell: UITableViewCell {
    static let identifier = "CustomerTableViewCell"
    
    weak var delegate: CustomerTableViewCellDelegate?
    
    private let idLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let emailLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let balanceLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let sendButton: UIButton = {
       let button = UIButton()
        button.setTitle("Transfer", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let historyButton: UIButton = {
       let button = UIButton()
        button.setTitle("History", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var navigationController: UINavigationController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(idLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(balanceLabel)
        contentView.addSubview(sendButton)
        contentView.addSubview(historyButton)
        
        sendButton.backgroundColor = UIColor(named: "background")
        historyButton.backgroundColor = .red
        
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        historyButton.addTarget(self, action: #selector(didTapHistoryButton), for: .touchUpInside)

    }
    
    @objc private func didTapSendButton() {
            delegate?.didTapSendButton(in: self)
        }

        @objc private func didTapHistoryButton() {
            delegate?.didTapHistoryButton(in: self)
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        idLabel.text = nil
        nameLabel.text = nil
        emailLabel.text = nil
        balanceLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpLayouts()
    }
    
    private func setUpLayouts() {
        idLabel.frame = CGRect(
            x: 10,
            y: 10,
            width: 100,
            height: 20
        )
        
        nameLabel.frame = CGRect(
            x: 10,
            y: 40,
            width: 200,
            height: 20
        )
        
        emailLabel.frame = CGRect(
            x: 10,
            y: 70,
            width: 200,
            height: 20
        )

        balanceLabel.frame = CGRect(
            x: 250,
            y: 70,
            width: 150,
            height: 20
        )
        
        historyButton.frame = CGRect(
            x: 10,
            y: 120,
            width: (contentView.frame.size.width/2)-20,
            height: 50
        )
        
        sendButton.frame = CGRect(
            x: historyButton.right+20,
            y: 120,
            width: (contentView.frame.size.width/2)-20,
            height: 50
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup(user: User) { //is working
        nameLabel.text = "Name: \(user.name)"
        emailLabel.text = "Email: \(user.email)"
        idLabel.text = "Your ID: \(user.id)"

        DatabaseManager.shared.getUser(email: user.email, id: user.id) { [weak self] fetchedUser in
            guard let self = self else { return }
            
            if let fetchedUser = fetchedUser {
                // Update the user object with the fetched user's data
                DispatchQueue.main.async {
                    self.balanceLabel.text = "Balance: \(fetchedUser.balance)$"
                }
            }
        }

    }
}
