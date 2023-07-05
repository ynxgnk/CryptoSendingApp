//
//  SignInHeaderView.swift
//  project
//
//  Created by Nazar Kopeika on 20.06.2023.
//

import UIKit

class SignInHeaderView: UIView {

    private let logoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let signInLabel: UILabel = {
       let label = UILabel()
        label.contentMode = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "Sign Up to CryptoBase!"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(logoImageView)
        addSubview(signInLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = frame.size.width / 4
        logoImageView.frame = CGRect(x: (width-size)/4-20, y: 10, width: size, height: size)
        signInLabel.frame = CGRect(x: 0, y: logoImageView.bottom, width: width-40, height: height-size-30)
    }

}
