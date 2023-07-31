//
//  NewsViewController.swift
//  project
//
//  Created by Nazar Kopeika on 17.06.2023.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {
    
    private let newsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(NewsTableViewCell.self,
                       forCellReuseIdentifier: NewsTableViewCell.identifier)
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(named: "background")
        view.backgroundColor = UIColor(named: "background")
        title = "News"
        view.addSubview(newsTable)
        view.backgroundColor = UIColor(named: "background")
        fetchTopNews()
        addSearchButton()
    }
    
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [NewsTitlesModel]()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsTable.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height)
        newsTable.backgroundColor = UIColor(named: "background")
    }
    
    private func addSearchButton() {
        let _ = navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        
    }
    
    @objc private func didTapSearch() {
        let vc = SearchNewsViewController()
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    private func fetchTopNews() {
        NewsAPICaller.shared.getTopNews { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Description",
                        author: $0.author,
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.newsTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.section])
        cell.layer.cornerRadius = 20
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(named: "cellbackground")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}


