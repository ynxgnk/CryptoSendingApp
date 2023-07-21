//
//  CustomerTableViewCell.swift
//  project
//
//  Created by Nazar Kopeika on 02.07.2023.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    static let identifier = "CustomerTableViewCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(idLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(balanceLabel)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup(user: User) {
        nameLabel.text = "Name: \(user.name)"
        emailLabel.text = "Email: \(user.email)"
        idLabel.text = "ID: \(user.id)"
        
        DatabaseManager.shared.getUserBalance(for: user.id) { [weak self] balance, error in
            guard let self = self else { return }
            
            if let error = error {
                // Handle the error if needed
                print("Error fetching balance from Firestore: \(error)")
            } else {
                // Update the balanceLabel with the fetched balance
                if let balance = balance {
                    DispatchQueue.main.async {
                        self.balanceLabel.text = "Balance: \(balance)"
                    }
                }
            }
        }
    }
}
