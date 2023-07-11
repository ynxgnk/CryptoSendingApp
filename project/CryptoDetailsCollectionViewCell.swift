//
//  CryptoDetailsCollectionViewCell.swift
//  project
//
//  Created by Nazar Kopeika on 07.07.2023.
//

import UIKit

class CryptoDetailsCollectionViewCell: UITableViewCell {
    static let identifier = "CryptoDetailsCollectionViewCell"
    
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let overviewLabel: UILabel = {
       let label = UILabel()
        label.text = "Overview"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()

    private let currectPriceTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Price"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let currectPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let currentPricePercentageLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.text = "Market Cap"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let marketCapPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let marketCapPricePercentageLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let rankTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Rank"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let rankLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let volumeTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Volume"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()



    private let additionalOverviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Additional details"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    private let high24h: UILabel = {
        let label = UILabel()
        label.text = "24H High"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let priceHigh24h: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let priceChange24h: UILabel = {
        let label = UILabel()
        label.text = "24H Price Change"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let priceChange24hPrice: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let priceChange24hPercentage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let low24h: UILabel = {
        let label = UILabel()
        label.text = "24H Low"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let priceLow24h: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let marketCapChange: UILabel = {
        let label = UILabel()
        label.text = "24H Market CapChange"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let marketPriceChange24hPrice: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let marketPriceChange24hPercentage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.frame = contentView.bounds
        addOverviewSubviews()
        addAdditionalSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutOverview()
        layoutAdditional()
    }

    private func addAdditionalSubviews() {
        contentView.addSubview(additionalOverviewLabel)
        additionalOverviewLabel.backgroundColor = .red
        contentView.addSubview(high24h)
        high24h.backgroundColor = .blue
        contentView.addSubview(priceHigh24h)
        priceHigh24h.backgroundColor = .brown
        contentView.addSubview(priceChange24h)
        priceChange24h.backgroundColor = .green
        contentView.addSubview(priceChange24hPrice)
        priceChange24hPrice.backgroundColor = .link
        contentView.addSubview(priceChange24hPercentage)
        priceChange24hPercentage.backgroundColor = .systemPink
        contentView.addSubview(low24h)
        low24h.backgroundColor = .black
        contentView.addSubview(priceLow24h)
        priceLow24h.backgroundColor = .purple
        contentView.addSubview(marketCapChange)
        marketCapChange.backgroundColor = .gray
        contentView.addSubview(marketPriceChange24hPrice)
        marketPriceChange24hPrice.backgroundColor = .orange
        contentView.addSubview(marketPriceChange24hPercentage)
        marketPriceChange24hPercentage.backgroundColor = .red
    }

    private func layoutAdditional() {
        additionalOverviewLabel.frame = CGRect(
            x: 20,
            y: 380,
            width: 200,
            height: 20
        )

        high24h.frame = CGRect(
            x: 20,
            y: 430,
            width: 100,
            height: 20
        )

        priceHigh24h.frame = CGRect(
            x: 20,
            y: 460,
            width: 100,
            height: 20
        )

        priceChange24h.frame = CGRect(
            x: 20,
            y: 490,
            width: 130,
            height: 20
        )

        priceChange24hPrice.frame = CGRect(
            x: 20,
            y: 520,
            width: 100,
            height: 20
        )

        priceChange24hPercentage.frame = CGRect(
            x: 20,
            y: 550,
            width: 100,
            height: 20
        )

        low24h.frame = CGRect(
            x: 180,
            y: 430,
            width: 100,
            height: 20
        )

        priceLow24h.frame = CGRect(
            x: 180,
            y: 460,
            width: 100,
            height: 20
        )

        marketCapChange.frame = CGRect(
            x: 180,
            y: 490,
            width: 180,
            height: 20
        )

        marketPriceChange24hPrice.frame = CGRect(
            x: 180,
            y: 520,
            width: 100,
            height: 20
        )

        marketPriceChange24hPercentage.frame = CGRect(
            x: 180,
            y: 550,
            width: 100,
            height: 20
        )
    }

    private func addOverviewSubviews() {
        contentView.addSubview(logoImageView)
        logoImageView.backgroundColor = .green
        contentView.addSubview(overviewLabel)
        overviewLabel.backgroundColor = .red
        contentView.addSubview(currectPriceTextLabel)
        currectPriceTextLabel.backgroundColor = .blue
        contentView.addSubview(currectPriceLabel)
        currectPriceLabel.backgroundColor = .brown
        contentView.addSubview(currentPricePercentageLabel)
        currentPricePercentageLabel.backgroundColor = .green
        contentView.addSubview(marketCapLabel)
        marketCapLabel.backgroundColor = .systemPink
        contentView.addSubview(marketCapPriceLabel)
        marketCapPriceLabel.backgroundColor = .black
        contentView.addSubview(marketCapPricePercentageLabel)
        marketCapPricePercentageLabel.backgroundColor = .purple
        contentView.addSubview(rankTextLabel)
        rankTextLabel.backgroundColor = .gray
        contentView.addSubview(rankLabel)
        rankLabel.backgroundColor = .orange
        contentView.addSubview(volumeTextLabel)
        volumeTextLabel.backgroundColor = .red
        contentView.addSubview(volumeLabel)
        volumeLabel.backgroundColor = .brown
    }

    private func layoutOverview() {
        logoImageView.frame = CGRect(
            x: (contentView.frame.size.width/2)-50,
            y: 20,
            width: 100,
            height: 100
        )
        
        overviewLabel.frame = CGRect(
            x: 20,
            y: 140,
            width: 100,
            height: 20
        )

        currectPriceTextLabel.frame = CGRect(
            x: 20,
            y: 190,
            width: 100,
            height: 20
        )

        currectPriceLabel.frame = CGRect(
            x: 20,
            y: 220,
            width: 100,
            height: 20
        )

        currentPricePercentageLabel.frame = CGRect(
            x: 20,
            y: 250,
            width: 100,
            height: 20
        )

        rankTextLabel.frame = CGRect(
            x: 20,
            y: 280,
            width: 100,
            height: 20
        )

        rankLabel.frame = CGRect(
            x: 20,
            y: 310,
            width: 100,
            height: 20
        )

        marketCapLabel.frame = CGRect(
            x: 180,
            y: 190,
            width: 100,
            height: 20
        )

        marketCapPriceLabel.frame = CGRect(
            x: 180,
            y: 220,
            width: 100,
            height: 20
        )

        marketCapPricePercentageLabel.frame = CGRect(
            x: 180,
            y: 250,
            width: 140,
            height: 20
        )

        volumeTextLabel.frame = CGRect(
            x: 180,
            y: 280,
            width: 100,
            height: 20
        )

        volumeLabel.frame = CGRect(
            x: 180,
            y: 310,
            width: 100,
            height: 20
        )
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView.image = nil
        currectPriceLabel.text = nil
        currentPricePercentageLabel.text = nil
        rankLabel.text = nil
        marketCapPriceLabel.text = nil
        marketCapPricePercentageLabel.text = nil
        volumeLabel.text = nil
        priceHigh24h.text = nil
        priceChange24hPrice.text = nil
        priceChange24hPercentage.text = nil
        priceLow24h.text = nil
        marketPriceChange24hPrice.text = nil
        marketPriceChange24hPercentage.text = nil
    }

    public func configureDetails(with viewModel: CryptoDetailsCollectionViewCellViewModel) {
        
        currectPriceLabel.text = viewModel.currentPrice
        currentPricePercentageLabel.text = viewModel.currentPricePercentage
        rankLabel.text = viewModel.rank
        
        marketCapPriceLabel.text = viewModel.marketCapPrice
        marketCapPricePercentageLabel.text = viewModel.marketCapPercentage
        volumeLabel.text = viewModel.volume
        
        priceHigh24h.text = viewModel.high24
        priceChange24hPrice.text = viewModel.priceChange24
        priceChange24hPercentage.text = viewModel.priceChange24Percentage
        
        priceLow24h.text = viewModel.low24
        marketPriceChange24hPrice.text = viewModel.marketCapChange
        marketCapPricePercentageLabel.text = viewModel.marketPriceChange24Percentage
        
        if let data = viewModel.cryptoImageData {
            logoImageView.image = UIImage(data: data)
        }
        else {
            logoImageView.image = nil
            
            if let url = viewModel.logoImage {
                //fetch
                URLSession.shared.dataTask(with: url) { [weak self] data , _, error in
                    guard let data = data, error == nil else {
                        return
                    }
                    
                    viewModel.cryptoImageData = data
                    
                    DispatchQueue.main.async {
                        self?.logoImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
    }
}
