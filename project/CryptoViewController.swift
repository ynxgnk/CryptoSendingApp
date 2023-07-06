//
//  CryptoViewController.swift
//  project
//
//  Created by Nazar Kopeika on 18.06.2023.
//

import SafariServices
import UIKit

class CryptoViewController: UIViewController {
    
    private let cryptoTable: UITableView = {
        let table = UITableView()
        table.register(CryptoTableViewCell.self,
                       forCellReuseIdentifier: CryptoTableViewCell.identifier)
        table.backgroundColor = UIColor(named: "background")
        table.layer.cornerRadius = 20
        return table
    }()
    
    private let cryptoScrollCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(NewsCollectionViewCell.self,
                      forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    private let newsLabel: UILabel = {
       let label = UILabel()
        label.text = "News"
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let cryptoLabel: UILabel = {
       let label = UILabel()
        label.text = "Live Prices"
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
//        spinner.backgroundColor = .red
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        view.addSubvirew(spinner)
        //        spinner.startAnimating()
        //        addConstraints()
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "background")
        view.backgroundColor = UIColor(named: "background")
        
        cryptoScrollCollectionView.showsHorizontalScrollIndicator = false
        cryptoTable.showsVerticalScrollIndicator = false
        cryptoTable.delegate = self
        cryptoTable.dataSource = self
        cryptoScrollCollectionView.delegate = self
        cryptoScrollCollectionView.dataSource = self
        view.addSubview(cryptoTable)
        view.addSubview(cryptoScrollCollectionView)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2.2) {
            self.view.addSubview(self.cryptoLabel)
            self.view.addSubview(self.newsLabel)
            self.spinner.stopAnimating()
        }
        
            self.fetchCryptoTableViewData()
            self.fetchTopNews()
    }
    
    private func addConstraints() { /* 1352 */
        NSLayoutConstraint.activate([ /* 1353 */
            spinner.heightAnchor.constraint(equalToConstant: 350), /* 1354 */
            spinner.widthAnchor.constraint(equalToConstant: 80), /* 1354 */
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor), /* 1354 */
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor), /* 1354 */
                                    ])
    }
    
    private var viewModels = [CryptoTableViewCellViewModel]()
    private var newsViewModels = [NewsTableViewCellViewModel]()
    private var cryptoCoins = [CryptoCoinModel]()
    private var articles = [NewsTitlesModel]()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        newsLabel.frame = CGRect(
            x: 30,
            y: 80,
            width: 300,
            height: 30
        )
        
        cryptoLabel.frame = CGRect(
            x: 30,
            y: 340,
            width: 300,
            height: 30
        )
        
        cryptoTable.separatorStyle = .none
        cryptoTable.frame = CGRect(
            x: view.safeAreaInsets.left+5,
            y: 380,
            width: view.frame.size.width-10,
            height: view.frame.size.height-380
        )
        
        view.backgroundColor = UIColor(named: "background")
        cryptoScrollCollectionView.frame = CGRect(
            x: 5,
            y: 130,
            width: view.frame.size.width,
            height: 180
        )
        
    }
    
    private func fetchTopNews() { //tyt
        NewsAPICaller.shared.getTopNews { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.newsViewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Description",
                        author: $0.author,
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.cryptoScrollCollectionView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchCryptoTableViewData() {
        CryptoAPICaller.shared.fetchCryptoData { [weak self] result in
            switch result {
            case .success(let coins):
                self?.cryptoCoins = coins.sorted(by: { $0.currentPrice > $1.currentPrice })
                self?.viewModels = coins.compactMap({
                    CryptoTableViewCellViewModel(
                        cryptoImageUrl: URL(string: $0.image),
                        cryptoTitle: $0.name,
                        cryptoSubtitle: $0.symbol,
                        cryptoPrice: String(describing: $0.currentPrice.toCurrency()),
                        cryptoPercent: $0.priceChangePercentage24H
                    )
                })
                
                DispatchQueue.main.async {
                    self?.cryptoTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /*
    
    private func fetchCryptoCollectionViewData() {
        CryptoAPICaller.shared.fetchCryptoData { [weak self] result in
            switch result {
            case .success(let coins):
                self?.cryptoCoins = coins.sorted(by: { $0.marketCapChangePercentage24H! > $1.marketCapChangePercentage24H! })
                self?.viewModels = coins.compactMap({
                    CryptoTableViewCellViewModel(
                        cryptoImageUrl: URL(string: $0.image),
                        cryptoTitle: $0.name,
                        cryptoSubtitle: $0.symbol,
                        cryptoPrice: String(describing: $0.currentPrice.toCurrency()),
                        cryptoPercent: $0.priceChangePercentage24H
                    )
                })
                
                DispatchQueue.main.async {
                    self?.cryptoScrollCollectionView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    */
    
}

//MARK: - TableView
extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {
            fatalError()
        }
        
        cell.layer.cornerRadius = 20
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(named: "cellbackground")
        cell.configure(with: viewModels[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let cryptoDetailsVC = CryptoDetailsViewController()
        navigationController?.pushViewController(cryptoDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.isHidden = true
        headerView.backgroundColor = UIColor(named: "background")
        return headerView
    }
}

//MARK: - CollectionView
extension CryptoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        newsViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as? NewsCollectionViewCell else { // tyt CryptoScrollCollectionViewCell
            fatalError()
        }
        cell.layer.cornerRadius = 20
        cell.backgroundColor = UIColor(named: "cellbackground")
//        cell.configureTopMovers(with: viewModels[indexPath.section]) //tyt
        cell.configure(with: newsViewModels[indexPath.section])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]

        guard let url = URL(string: article.url ?? "") else {
            return
        }

        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.frame.size.width - 40
        let cellHeight = CGFloat(180)

        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
