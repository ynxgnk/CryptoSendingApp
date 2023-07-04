//
//  CryptoScrollCollectionViewCell.swift
//  project
//
//  Created by Nazar Kopeika on 19.06.2023.
//

/*

 I am not using it because replaced TopMovers with News, so NewsTableViewCell is not used too.
 
import UIKit

class CryptoScrollCollectionViewCell: UICollectionViewCell {
    static let identifier = "CryptoScrollCollectionViewCell"
    
    private let cryptoImageView: UIImageView = {
        let view = UIImageView()
//        view.image = UIImage(systemName: "car")
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let cryptoTitleLabel: UILabel = {
        let label = UILabel()
//        label.text = "Bitcoin"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let cryptoSubtitleLabel: UILabel = {
       let label = UILabel()
//        label.text = "BTC"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let cryptoPriceLabel: UILabel = {
       let label = UILabel()
//        label.text = "100,23 $"
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private let cryptoPercentageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cryptoImageView)
//        cryptoImageView.backgroundColor = .green
        contentView.addSubview(cryptoTitleLabel)
//        cryptoTitleLabel.backgroundColor = .yellow
        contentView.addSubview(cryptoSubtitleLabel)
//        cryptoSubtitleLabel.backgroundColor = .brown
        contentView.addSubview(cryptoPriceLabel)
//        cryptoPriceLabel.backgroundColor = .systemPink
        contentView.addSubview(cryptoPercentageLabel)
//        cryptoPercentageLabel.backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cryptoImageView.frame = CGRect(
            x: contentView.safeAreaInsets.left + 10,
            y: 40,
            width: 85,
            height: 85
        )
        
        cryptoTitleLabel.frame = CGRect(
            x: 100+10,
            y: 40,
            width: 100,
            height: 30
        )

        cryptoSubtitleLabel.frame = CGRect(
            x: 100+10,
            y: 75,
            width: 100,
            height: 30
        )

        cryptoPriceLabel.frame = CGRect(
            x: 60+20+150,
            y: 40,
            width: 100,
            height: 30
        )

        cryptoPercentageLabel.frame = CGRect(
            x: 60+20+150,
            y: 75,
            width: 100,
            height: 30
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cryptoImageView.image = nil
        cryptoTitleLabel.text = nil
        cryptoSubtitleLabel.text = nil
        cryptoPriceLabel.text = nil
        cryptoPercentageLabel.text = nil
    }
    
    
    public func configureTopMovers(with viewModel: CryptoTableViewCellViewModel) {
        cryptoTitleLabel.text = viewModel.cryptoTitle
        cryptoSubtitleLabel.text = viewModel.cryptoSubtitle.uppercased()
        cryptoPriceLabel.text = viewModel.cryptoPrice
        cryptoPercentageLabel.text = String(describing: viewModel.cryptoPercent.toPercentageString())
        cryptoPercentageLabel.textColor = viewModel.cryptoPercent > 0 ? .systemGreen : .red
        
        //Image
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
                    
                    viewModel.cryptoImageData = nil
                    
                    DispatchQueue.main.async {
                        self?.cryptoImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
    }
}

*/

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewsCollectionViewCell"
    
    private let newsImageView: UIImageView = {
       let view = UIImageView()
//        view.image = UIImage(systemName: "car")
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let newsTitleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
//        label.text = "Title"
        label.textColor = .white
        return label
    }()
    
    private let newsDescriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
//        label.text = "Description"
        return label
    }()
    
    private let newsAuthorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.isUserInteractionEnabled = false
        contentView.clipsToBounds = true
        contentView.addSubview(newsImageView)
//        newsImageView.backgroundColor = .orange
        contentView.addSubview(newsTitleLabel)
//        newsTitleLabel.backgroundColor = .blue
        contentView.addSubview(newsDescriptionLabel)
//        newsDescriptionLabel.backgroundColor = .green
        contentView.addSubview(newsAuthorLabel)
//        newsAuthorLabel.backgroundColor = .rred
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        newsTitleLabel.text = nil
        newsDescriptionLabel.text = nil
        newsAuthorLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newsImageView.frame = CGRect(
            x: 15,
            y: 15+30+10,
            width: 140,
            height: 110
        )
        newsTitleLabel.frame = CGRect(
            x: 15,
            y: 15,
            width: contentView.frame.size.width-25,
            height: 30
        )
        newsDescriptionLabel.frame = CGRect(
            x: 140+15+15,
            y: 15+30+10,
            width: contentView.frame.size.width-180,
            height: (contentView.frame.size.height/1.75)-10
        )
        newsAuthorLabel.frame = CGRect(
            x: 140+15+15,
            y: 60+(contentView.frame.size.height/1.75)-10,
            width: contentView.frame.size.width-180,
            height: 15
        )
    }
    
    public func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        newsDescriptionLabel.text = viewModel.subtitle
        newsAuthorLabel.text = viewModel.author
        
        //Image
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            //fetch
            URLSession.shared.dataTask(with: url) { [weak self] data , _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }

}
