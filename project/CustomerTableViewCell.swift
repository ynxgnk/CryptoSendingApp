//
//  CustomerTableViewCell.swift
//  project
//
//  Created by Nazar Kopeika on 02.07.2023.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    static let identifier = "CustomerTableViewCell"

//    @IBOutlet weak var idLabel: UILabel!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var emailLabel: UILabel!
//    @IBOutlet weak var balanceLabel: UILabel!
    
    private let idLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let emailLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let balanceLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
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
//        idLabel.backgroundColor = .red
        
        nameLabel.frame = CGRect(
            x: 10,
            y: 30,
            width: 200,
            height: 30
        )
//        nameLabel.backgroundColor = .orange
        
        emailLabel.frame = CGRect(
            x: 10,
            y: 60,
            width: 200,
            height: 30
        )
//        emailLabel.backgroundColor = .blue

        balanceLabel.frame = CGRect(
            x: 250,
            y: 30,
            width: 150,
            height: 30
        )
//        balanceLabel.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
//    func setup(customer: Customer){
//        nameLabel.text = customer.name
//        emailLabel.text = customer.email + ","
//        idLabel.text = "ID: " + String(customer.id1)
//        balanceLabel.text = "\(customer.balance)$"
//    }
    
    func setup(user: User) { //tyt
        nameLabel.text = "Name: \(user.name)"
        emailLabel.text = "Email: \(user.email)"
        idLabel.text = "ID: \(user.id)"
        balanceLabel.text = "Balance: \(user.balance)"
    }
}
