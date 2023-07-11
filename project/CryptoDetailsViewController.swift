//
//  CryptoDetailsViewController.swift
//  project
//
//  Created by Nazar Kopeika on 19.06.2023.
//

import UIKit

class CryptoDetailsViewController: UIViewController {
    
    private let detailsTableView: UITableView = {
       let table = UITableView()
        table.register(CryptoDetailsCollectionViewCell.self,
                       forCellReuseIdentifier: CryptoDetailsCollectionViewCell.identifier)
        return table
    }()
    
//    private let overviewLabel: UILabel = {
//       let label = UILabel()
//        label.text = "Overview"
//        label.font = .systemFont(ofSize: 22, weight: .semibold)
//        return label
//    }()
//
//    private let currectPriceTextLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Current Price"
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        return label
//    }()
//
//    private let currectPriceLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = .systemFont(ofSize: 16, weight: .semibold)
//        return label
//    }()
//
//    private let currentPricePercentageLabel: UILabel = {
//       let label = UILabel()
//        label.numberOfLines = 1
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        return label
//    }()
//
//    private let marketCapLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Market Cap"
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        return label
//    }()
//
//    private let marketCapPriceLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = .systemFont(ofSize: 16, weight: .semibold)
//        return label
//    }()
//
//    private let marketCapPricePercentageLabel: UILabel = {
//       let label = UILabel()
//        label.numberOfLines = 1
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        return label
//    }()
//
//    private let rankTextLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Rank"
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        return label
//    }()
//
//    private let rankLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = .systemFont(ofSize: 16, weight: .semibold)
//        return label
//    }()
//
//    private let volumeTextLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Volume"
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        return label
//    }()
//
//    private let volumeLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = .systemFont(ofSize: 16, weight: .semibold)
//        return label
//    }()
//
//
//
//    private let additionalOverviewLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Additional details"
//        label.font = .systemFont(ofSize: 18, weight: .semibold)
//        return label
//    }()
//
//    private let high24h: UILabel = {
//        let label = UILabel()
//        label.text = "24H High"
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        return label
//    }()
//
//    private let priceHigh24h: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = .systemFont(ofSize: 16, weight: .semibold)
//        return label
//    }()
//
//    private let priceChange24h: UILabel = {
//        let label = UILabel()
//        label.text = "24H Price Change"
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        return label
//    }()
//
//    private let priceChange24hPrice: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = .systemFont(ofSize: 16, weight: .semibold)
//        return label
//    }()
//
//    private let priceChange24hPercentage: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = .systemFont(ofSize: 16, weight: .semibold)
//        return label
//    }()
//
//    private let low24h: UILabel = {
//        let label = UILabel()
//        label.text = "24H Low"
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        return label
//    }()
//
//    private let priceLow24h: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = .systemFont(ofSize: 16, weight: .semibold)
//        return label
//    }()
//
//    private let marketCapChange: UILabel = {
//        let label = UILabel()
//        label.text = "24H Market CapChange"
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        return label
//    }()
//
//    private let marketPriceChange24hPrice: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = .systemFont(ofSize: 16, weight: .semibold)
//        return label
//    }()
//
//    private let marketPriceChange24hPercentage: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = .systemFont(ofSize: 16, weight: .semibold)
//        return label
//    }()
    
    //
    //    private func addAdditionalSubviews() {
    //        view.addSubview(additionalOverviewLabel)
    //        additionalOverviewLabel.backgroundColor = .red
    //        view.addSubview(high24h)
    //        high24h.backgroundColor = .blue
    //        view.addSubview(priceHigh24h)
    //        priceHigh24h.backgroundColor = .brown
    //        view.addSubview(priceChange24h)
    //        priceChange24h.backgroundColor = .green
    //        view.addSubview(priceChange24hPrice)
    //        priceChange24hPrice.backgroundColor = .link
    //        view.addSubview(priceChange24hPercentage)
    //        priceChange24hPercentage.backgroundColor = .systemPink
    //        view.addSubview(low24h)
    //        low24h.backgroundColor = .black
    //        view.addSubview(priceLow24h)
    //        priceLow24h.backgroundColor = .purple
    //        view.addSubview(marketCapChange)
    //        marketCapChange.backgroundColor = .gray
    //        view.addSubview(marketPriceChange24hPrice)
    //        marketPriceChange24hPrice.backgroundColor = .orange
    //        view.addSubview(marketPriceChange24hPercentage)
    //        marketPriceChange24hPercentage.backgroundColor = .red
    //    }
    //
    //    private func layoutAdditional() {
    //        additionalOverviewLabel.frame = CGRect(
    //            x: 20,
    //            y: 300,
    //            width: 200,
    //            height: 20
    //        )
    //
    //        high24h.frame = CGRect(
    //            x: 20,
    //            y: 345,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        priceHigh24h.frame = CGRect(
    //            x: 20,
    //            y: 375,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        priceChange24h.frame = CGRect(
    //            x: 20,
    //            y: 405,
    //            width: 130,
    //            height: 20
    //        )
    //
    //        priceChange24hPrice.frame = CGRect(
    //            x: 20,
    //            y: 435,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        priceChange24hPercentage.frame = CGRect(
    //            x: 20,
    //            y: 465,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        low24h.frame = CGRect(
    //            x: 180,
    //            y: 345,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        priceLow24h.frame = CGRect(
    //            x: 180,
    //            y: 375,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        marketCapChange.frame = CGRect(
    //            x: 180,
    //            y: 405,
    //            width: 180,
    //            height: 20
    //        )
    //
    //        marketPriceChange24hPrice.frame = CGRect(
    //            x: 180,
    //            y: 435,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        marketPriceChange24hPercentage.frame = CGRect(
    //            x: 180,
    //            y: 465,
    //            width: 100,
    //            height: 20
    //        )
    //    }
    //
    //    private func addOverviewSubviews() {
    //        view.addSubview(overviewLabel)
    //        overviewLabel.backgroundColor = .red
    //        view.addSubview(currectPriceTextLabel)
    //        currectPriceTextLabel.backgroundColor = .blue
    //        view.addSubview(currectPriceLabel)
    //        currectPriceLabel.backgroundColor = .brown
    //        view.addSubview(currentPricePercentageLabel)
    //        currentPricePercentageLabel.backgroundColor = .green
    //        view.addSubview(marketCapLabel)
    //        marketCapLabel.backgroundColor = .systemPink
    //        view.addSubview(marketCapPriceLabel)
    //        marketCapPriceLabel.backgroundColor = .black
    //        view.addSubview(marketCapPricePercentageLabel)
    //        marketCapPricePercentageLabel.backgroundColor = .purple
    //        view.addSubview(rankTextLabel)
    //        rankTextLabel.backgroundColor = .gray
    //        view.addSubview(rankLabel)
    //        rankLabel.backgroundColor = .orange
    //        view.addSubview(volumeTextLabel)
    //        volumeTextLabel.backgroundColor = .red
    //        view.addSubview(volumeLabel)
    //        volumeLabel.backgroundColor = .brown
    //    }
    //
    //    private func layoutOverview() {
    //        overviewLabel.frame = CGRect(
    //            x: 20,
    //            y: 35,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        currectPriceTextLabel.frame = CGRect(
    //            x: 20,
    //            y: 80,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        currectPriceLabel.frame = CGRect(
    //            x: 20,
    //            y: 110,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        currentPricePercentageLabel.frame = CGRect(
    //            x: 20,
    //            y: 140,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        rankTextLabel.frame = CGRect(
    //            x: 20,
    //            y: 185,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        rankLabel.frame = CGRect(
    //            x: 20,
    //            y: 215,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        marketCapLabel.frame = CGRect(
    //            x: 180,
    //            y: 80,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        marketCapPriceLabel.frame = CGRect(
    //            x: 180,
    //            y: 110,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        marketCapPricePercentageLabel.frame = CGRect(
    //            x: 180,
    //            y: 140,
    //            width: 140,
    //            height: 20
    //        )
    //
    //        volumeTextLabel.frame = CGRect(
    //            x: 180,
    //            y: 185,
    //            width: 100,
    //            height: 20
    //        )
    //
    //        volumeLabel.frame = CGRect(
    //            x: 180,
    //            y: 215,
    //            width: 100,
    //            height: 20
    //        )
    //    }

    private var cryptoCoins = [CryptoCoinModel]()
    private var viewModels1 = [CryptoDetailsCollectionViewCellViewModel]()
    private var cryptoCoin: CryptoCoinModel?
    private var selectedCryptoCoin: CryptoCoinModel?

    init(cryptoCoin: CryptoCoinModel) {
        self.cryptoCoin = cryptoCoin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        detailsTableView.backgroundColor = UIColor(named: "background")
//        view.addSubview(detailsTableView)
//
//        detailsTableView.delegate = self
//        detailsTableView.dataSource = self
//        fetchCryptoDetailsData()
//    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            detailsTableView.backgroundColor = UIColor(named: "background")
            view.addSubview(detailsTableView)

            detailsTableView.delegate = self
            detailsTableView.dataSource = self
            fetchCryptoDetailsData()
        }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailsTableView.frame = view.bounds
    }
    
//    private func fetchCryptoDetailsData() {
//        CryptoAPICaller.shared.fetchCryptoData { [weak self] result in
//            switch result {
//            case .success(let coins):
//                self?.cryptoCoins = coins
//                self?.viewModels1 = coins.compactMap({
//                    CryptoDetailsCollectionViewCellViewModel(
//                        logoImage: URL(string: $0.image),
//                        currentPrice: $0.currentPrice.toCurrency(),
//                        currentPricePercentage: $0.priceChangePercentage24H.toCurrency(),
//                        marketCapPrice: $0.marketCap?.toCurrency() ?? "No Market Cap",
//                        marketCapPercentage: $0.marketCapChangePercentage24H?.toCurrency() ?? "No Percentage",
//                        rank: $0.marketCapRank.formatted(),
//                        volume: $0.totalVolume?.toCurrency() ?? "No Volume",
//                        high24: $0.high24H?.toCurrency() ?? "No Price",
//                        priceChange24: $0.priceChange24H.toCurrency(),
//                        priceChange24Percentage: $0.priceChangePercentage24H.toCurrency(),
//                        low24: $0.low24H?.toCurrency() ?? "No Price",
//                        marketCapChange: $0.marketCapChange24H?.toCurrency() ?? "No Price",
//                        marketPriceChange24Percentage: $0.marketCapChangePercentage24H?.toCurrency() ?? "No Price"
//                    )
//                })
//
//
//                DispatchQueue.main.async {
//                    self?.detailsTableView.reloadData()
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    private func fetchCryptoDetailsData() {
        CryptoAPICaller.shared.fetchCryptoData { [weak self] result in
            switch result {
            case .success(let coins):
                self?.cryptoCoins = coins
                if let selectedCryptoCoin = self?.cryptoCoin {
                    let viewModel = coins.compactMap({ cryptoCoin -> CryptoDetailsCollectionViewCellViewModel? in
                        if cryptoCoin.id == selectedCryptoCoin.id {
                            return CryptoDetailsCollectionViewCellViewModel(
                                logoImage: URL(string: cryptoCoin.image),
                                currentPrice: cryptoCoin.currentPrice.toCurrency(),
                                currentPricePercentage: cryptoCoin.priceChangePercentage24H.toCurrency(),
                                marketCapPrice: cryptoCoin.marketCap?.toCurrency() ?? "No Market Cap",
                                marketCapPercentage: cryptoCoin.marketCapChangePercentage24H?.toCurrency() ?? "No Percentage",
                                rank: cryptoCoin.marketCapRank.formatted(),
                                volume: cryptoCoin.totalVolume?.toCurrency() ?? "No Volume",
                                high24: cryptoCoin.high24H?.toCurrency() ?? "No Price",
                                priceChange24: cryptoCoin.priceChange24H.toCurrency(),
                                priceChange24Percentage: cryptoCoin.priceChangePercentage24H.toCurrency(),
                                low24: cryptoCoin.low24H?.toCurrency() ?? "No Price",
                                marketCapChange: cryptoCoin.marketCapChange24H?.toCurrency() ?? "No Price",
                                marketPriceChange24Percentage: cryptoCoin.marketCapChangePercentage24H?.toCurrency() ?? "No Price"
                            )
                        }
                        return nil
                    })

                    self?.viewModels1 = viewModel
                    DispatchQueue.main.async {
                        self?.detailsTableView.reloadData()
                    }
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

extension CryptoDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels1.count
//        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoDetailsCollectionViewCell.identifier, for: indexPath) as? CryptoDetailsCollectionViewCell else {
            fatalError()
        }
        cell.configureDetails(with: viewModels1[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCryptoCoin = cryptoCoins[indexPath.section]
        let detailsVC = CryptoDetailsViewController(cryptoCoin: selectedCryptoCoin)
        navigationController?.pushViewController(detailsVC, animated: true)

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}
