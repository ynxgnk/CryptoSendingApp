//
//  CryptoTableViewCell.swift
//  project
//
//  Created by Nazar Kopeika on 18.06.2023.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    static let identifier = "CryptoTableViewCell"
        
    private let cryptoImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let cryptoTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private let cryptoSubtitleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let cryptoPriceLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let cryptoPercentageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cryptoImageView)
        contentView.addSubview(cryptoTitleLabel)
        contentView.addSubview(cryptoSubtitleLabel)
        contentView.addSubview(cryptoPriceLabel)
        contentView.addSubview(cryptoPercentageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cryptoImageView.image = nil
        cryptoTitleLabel.text = nil
        cryptoSubtitleLabel.text = nil
        cryptoPriceLabel.text = nil
        cryptoPercentageLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cryptoImageView.frame = CGRect(
            x: 20,
            y: cryptoImageView.safeAreaInsets.top+10,
            width: 60,
            height: 60
        )
        
        cryptoTitleLabel.frame = CGRect(
            x: cryptoImageView.safeAreaInsets.left+20+60+15,
            y: cryptoImageView.safeAreaInsets.top+10,
            width: 100,
            height: 20
        )
        
        cryptoSubtitleLabel.frame = CGRect(
            x: cryptoImageView.safeAreaInsets.right+20+60+15+5,
            y: cryptoTitleLabel.safeAreaInsets.top+10+30,
            width: 100,
            height: 20
        )
        
        cryptoPriceLabel.frame = CGRect(
            x: contentView.safeAreaInsets.left + 255,
            y: cryptoImageView.safeAreaInsets.top+10,
            width: 110,
            height: 20
        )
        
        cryptoPercentageLabel.frame = CGRect(
            x: contentView.safeAreaInsets.left+305,
            y: cryptoPriceLabel.safeAreaInsets.bottom+40,
            width: 60,
            height: 20
        )
    }
        
    public func configure(with viewModel: CryptoTableViewCellViewModel) {
        cryptoTitleLabel.text = viewModel.cryptoTitle
        cryptoSubtitleLabel.text = viewModel.cryptoSubtitle.uppercased()
        cryptoPriceLabel.text = viewModel.cryptoPrice
        cryptoPercentageLabel.text = String(describing: viewModel.cryptoPercent.toPercentageString())
        cryptoPercentageLabel.textColor = viewModel.cryptoPercent > 0 ? .systemGreen : .red

        
        if let data = viewModel.cryptoImageData {
            cryptoImageView.image = UIImage(data: data)
        }
        else {
            cryptoImageView.image = nil
            
            if let url = viewModel.cryptoImageUrl {
                //fetch
                URLSession.shared.dataTask(with: url) { [weak self] data , _, error in
                    guard let data = data, error == nil else {
                        return
                    }

                    viewModel.cryptoImageData = data

                    DispatchQueue.main.async {
                        self?.cryptoImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
    }
}
