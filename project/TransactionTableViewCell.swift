//
//  TransactionTableViewCell.swift
//  project
//
//  Created by Nazar Kopeika on 02.07.2023.
//

import UIKit

class TransctionTableViewCell: UITableViewCell {
    static let idenifier = "TransctionTableViewCell"

//    @IBOutlet weak var receiverLabel: UILabel!
//    @IBOutlet weak var amountLabel: UILabel!
    
    private let receiverLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let amountLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(receiverLabel)
        contentView.addSubview(amountLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        receiverLabel.frame = CGRect(
            x: 10,
            y: 20,
            width: 200,
            height: 25
        )
//        receiverLabel.backgroundColor = .black
        
        amountLabel.frame = CGRect(
            x: 200,
            y: 20,
            width: contentView.frame.size.width-210,
            height: 25
        )
//        amountLabel.backgroundColor = .green
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        receiverLabel.text = nil
        amountLabel.text = nil
    }
    
    
    func setup(receiver: String, amount: Int){
        receiverLabel.text = receiver
        amountLabel.text = "+ \(amount)$"
    }
}
