//
//  SettingsTableViewCell.swift
//  project
//
//  Created by Nazar Kopeika on 23.06.2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    static let identifier = "SettingsTableViewCell"
    
    let settingsImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "gear")
        image.backgroundColor = UIColor(named: "cellbackground")
        image.layer.cornerRadius = 20
        return image
    }()
    
    let settingsName: UILabel = {
        let label = UILabel()
        label.text = "Rate App"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
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
            width: 65,
            height: 65
        )
        
        settingsName.frame = CGRect(
            x: 100,
            y: 40,
            width: 150,
            height: 40
        )
        
    }
    
}
