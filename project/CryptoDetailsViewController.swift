//
//  CryptoDetailsViewController.swift
//  project
//
//  Created by Nazar Kopeika on 19.06.2023.
//

import UIKit

class CryptoDetailsViewController: UIViewController {
    
    let detailsTableView: UITableView = {
        let view = UITableView()
        view.register(CryptoDetailsCollectionViewCell.self,
                      forCellReuseIdentifier: CryptoDetailsCollectionViewCell.identifier)
        return view
    }()
    
    private var cryptoCoins = [CryptoCoinModel]()
    private var viewModels1 = [CryptoDetailsCollectionViewCellViewModel]()
    var cryptoCoin: CryptoCoinModel? //tyt

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
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
    
     func fetchCryptoDetailsData() {
        CryptoAPICaller.shared.fetchCryptoData { [weak self] result in
            switch result {
            case .success(let coins):
                self?.cryptoCoins = coins
                self?.viewModels1 = coins.compactMap({
                    CryptoDetailsCollectionViewCellViewModel(
                        currentPrice: $0.currentPrice.toCurrency(),
                        currentPricePercentage: $0.priceChangePercentage24H.toCurrency(),
                        marketCapPrice: $0.marketCap?.toCurrency() ?? "No Market Cap",
                        marketCapPercentage: $0.marketCapChangePercentage24H?.toCurrency() ?? "No Percentage",
                        rank: $0.marketCapRank.formatted(),
                        volume: $0.totalVolume?.toCurrency() ?? "No Volume",
                        high24: $0.high24H?.toCurrency() ?? "No Price",
                        priceChange24: $0.priceChange24H.toCurrency(),
                        priceChange24Percentage: $0.priceChangePercentage24H.toCurrency(),
                        low24: $0.low24H?.toCurrency() ?? "No Price",
                        marketCapChange: $0.marketCapChange24H?.toCurrency() ?? "No Price",
                        marketPriceChange24Percentage: $0.marketCapChangePercentage24H?.toCurrency() ?? "No Price"
                    )
                })

                DispatchQueue.main.async {
                    self?.detailsTableView.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoDetailsCollectionViewCell.identifier, for: indexPath) as? CryptoDetailsCollectionViewCell else {
            fatalError()
        }
        cell.configureDetails(with: viewModels1[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}
