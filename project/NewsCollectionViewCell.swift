
import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewsCollectionViewCell"
    
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
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let newsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
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
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsDescriptionLabel)
        contentView.addSubview(newsAuthorLabel)
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
    
    public func configureNews(with viewModel: NewsTableViewCellViewModel) {
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
