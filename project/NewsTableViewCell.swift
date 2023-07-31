//
//  NewsTableViewCell.swift
//  project
//
//  Created by Nazar Kopeika on 17.06.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    private let newsImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let newsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let newsAuthorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(newsImageView)
        addSubview(newsTitleLabel)
        addSubview(newsDescriptionLabel)
        addSubview(newsAuthorLabel)
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
        newsImageView.frame = CGRect(x: contentView.safeAreaInsets.left+5, y: contentView.safeAreaInsets.top+10, width: 150, height: 150)
        newsTitleLabel.frame = CGRect(x: 160+10, y: contentView.safeAreaInsets.top+10, width: contentView.frame.size.width-170, height: 30)
        newsDescriptionLabel.frame = CGRect(x: 160+10, y: 15+30, width: contentView.frame.size.width-170, height: (contentView.frame.size.height/1.75))
        newsAuthorLabel.frame = CGRect(x: 170, y: 45+(contentView.frame.size.height/1.75)+5, width: contentView.frame.size.width, height: 20)
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
