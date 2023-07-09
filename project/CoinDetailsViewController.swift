//
//  CoinDetailsViewController.swift
//  project
//
//  Created by Nazar Kopeika on 07.07.2023.
//

import UIKit

class CoinDetailsViewController: UIViewController {
    
    let coin: CryptoCoinModel
    let viewModel: CoinDetailsViewModel
    
    private let scrollView: UIScrollView
    private let chartView: ChartViewController
    private let overviewSectionView: CoinDetailsSection
    private let additionalDetailsSectionView: CoinDetailsSection
    
    init(coin: CryptoCoinModel) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coin: coin)
        
        self.scrollView = UIScrollView()
        self.chartView = ChartViewController(viewModel: viewModel)
        self.overviewSectionView = CoinDetailsSection(model: viewModel.overviewSectionModel)
        self.additionalDetailsSectionView = CoinDetailsSection(model: viewModel.additionalDetailsSectionModel)
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = coin.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.addSubview(chartView.view) // Add chartView's view property
        
        overviewSectionView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(overviewSectionView)
        
        additionalDetailsSectionView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(additionalDetailsSectionView)
    }
    
    private func setupConstraints() {
        // Add your constraints here
    }
}
