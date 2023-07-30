//
//  LastTransactionTableViewCell.swift
//  project
//
//  Created by Nazar Kopeika on 29.07.2023.
//

import UIKit

class LastTransactionTableViewCell: UITableViewCell {
    static let identifier = "LastTransactionTableViewCell"
    
    private let senderLabel: UILabel = {
       let label = UILabel()
        label.text = "SENDER"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let receiverLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let amountLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let successImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "transaction")
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        senderLabel.frame = CGRect(x: 30, y: 50, width: 100, height: 20)
        receiverLabel.frame = CGRect(x: 30, y: 80, width: 100, height: 20)
        amountLabel.frame = CGRect(x: 30, y: 110, width: 100, height: 20)
        successImage.frame = CGRect(x: contentView.frame.size.width/2, y: 200, width: 80, height: 80)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(senderLabel)
        contentView.addSubview(receiverLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(successImage)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        senderLabel.text = nil
        receiverLabel.text = nil
        amountLabel.text = nil
    }
    
//    func setup(receiver: String, sender: String, amount: Int64) { //default
//        receiverLabel.text = receiver
//        senderLabel.text = sender
//        amountLabel.text = String(amount)
//    }
    
//    func setup(receiverName: String, senderName: String, amount: Int64) {
//            receiverLabel.text = "Receiver: \(receiverName)"
////            senderLabel.text = "Sender: \(senderName)"
//            amountLabel.text = "Amount: \(amount)"
//        }
//
}
