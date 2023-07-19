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
        table.register(CryptoDetailsTableViewCell.self,
                       forCellReuseIdentifier: CryptoDetailsTableViewCell.identifier)
        return table
    }()

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTableView.backgroundColor = UIColor(named: "background")
        view.addSubview(detailsTableView)
        detailsTableView.separatorStyle = .none
        detailsTableView.isScrollEnabled = false
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        fetchCryptoDetailsData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailsTableView.frame = view.bounds
    }
    
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
                                currentPricePercentage: cryptoCoin.priceChangePercentage24H.toPercentageString(),
                                marketCapPrice: cryptoCoin.marketCap?.toCurrency() ?? "No Market Cap",
                                marketCapPercentage: cryptoCoin.marketCapChangePercentage24H?.toPercentageString() ?? "No Percentage",
                                rank: cryptoCoin.marketCapRank.formatted(),
                                volume: cryptoCoin.totalVolume?.toCurrency() ?? "No Volume",
                                high24: cryptoCoin.high24H?.toCurrency() ?? "No Price",
                                priceChange24: cryptoCoin.priceChange24H.toCurrency(),
                                priceChange24Percentage: cryptoCoin.priceChangePercentage24H.toPercentageString(),
                                low24: cryptoCoin.low24H?.toCurrency() ?? "No Price",
                                marketCapChange: cryptoCoin.marketCapChange24H?.toCurrency() ?? "No Price",
                                marketPriceChange24Percentage: cryptoCoin.marketCapChangePercentage24H?.toPercentageString() ?? "No Price"
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
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoDetailsTableViewCell.identifier, for: indexPath) as? CryptoDetailsTableViewCell else {
            fatalError()
        }
        cell.configureDetails(with: viewModels1[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let selectedCryptoCoin = cryptoCoins[indexPath.section]
//        let detailsVC = CryptoDetailsViewController(cryptoCoin: selectedCryptoCoin)
//        navigationController?.pushViewController(detailsVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}
