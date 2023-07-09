//
//  CoinDetailsSection.swift
//  project
//
//  Created by Nazar Kopeika on 07.07.2023.
//

//tyt

import UIKit

class CoinDetailsSection: UIView {
    
    let model: CryptoCoinDetailsSectionModel
    private let stackView: UIStackView
    private let titleLabel: UILabel
    private let gridView: UIStackView
    
    init(model: CryptoCoinDetailsSectionModel) {
        self.model = model
        
        self.stackView = UIStackView()
        self.titleLabel = UILabel()
        self.gridView = UIStackView()
        
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        stackView.axis = .vertical
        stackView.spacing = 20
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        gridView.axis = .vertical
        gridView.spacing = 20
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureContent() {
        titleLabel.text = model.title
        titleLabel.textAlignment = .left
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(gridView)
        
        for stat in model.stats {
            let statisticView = StatisticView(model: stat)
            gridView.addArrangedSubview(statisticView)
        }
    }
}
