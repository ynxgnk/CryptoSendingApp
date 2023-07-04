//
//  SettingsTableViewCell.swift
//  project
//
//  Created by Nazar Kopeika on 23.06.2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    static let identifier = "SettingsTableViewCell"
    
    private let settingsImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
//        image.image = UIImage(systemName: "gear")
        image.backgroundColor = .yellow
        image.layer.cornerRadius = 30
        return image
    }()
    
    private let settingsName: UILabel = {
       let label = UILabel()
//        label.text = "Rate App"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(settingsImage)
        contentView.addSubview(settingsName)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        settingsImage.frame = CGRect(
            x: 20,
            y: 30,
            width: 60,
            height: 60
        )
        
        settingsName.frame = CGRect(
            x: 100,
            y: 40,
            width: 100,
            height: 40
        )
        
    }
    
}
