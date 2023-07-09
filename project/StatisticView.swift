//
//  StatisticView.swift
//  project
//
//  Created by Nazar Kopeika on 07.07.2023.
//

import UIKit

class StatisticView: UIView {
    
    let model: StatiscticModel
    private let stackView: UIStackView
    private let titleLabel: UILabel
    private let valueLabel: UILabel
    private let percentageChangeStackView: UIStackView
    private let triangleImageView: UIImageView
    private let percentageChangeLabel: UILabel
    
    init(model: StatiscticModel) {
        self.model = model
        
        self.stackView = UIStackView()
        self.titleLabel = UILabel()
        self.valueLabel = UILabel()
        self.percentageChangeStackView = UIStackView()
        self.triangleImageView = UIImageView(image: UIImage(systemName: "triangle.fill"))
        self.percentageChangeLabel = UILabel()
        
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
        stackView.spacing = 4
        
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        
        valueLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        percentageChangeStackView.axis = .horizontal
        percentageChangeStackView.spacing = 4
        
        triangleImageView.contentMode = .scaleAspectFit
        triangleImageView.tintColor = .green
        
        percentageChangeLabel.font = UIFont.systemFont(ofSize: 12)
        percentageChangeLabel.textColor = .green
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
        valueLabel.text = model.value
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        
        if let percentChange = model.percentageChange {
            percentageChangeStackView.addArrangedSubview(triangleImageView)
            percentageChangeLabel.text = percentChange.toPercentageString()
            percentageChangeStackView.addArrangedSubview(percentageChangeLabel)
            stackView.addArrangedSubview(percentageChangeStackView)
        }
    }
}
