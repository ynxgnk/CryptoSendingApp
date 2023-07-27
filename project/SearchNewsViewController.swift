//
//  SearchNewsViewController.swift
//  project
//
//  Created by Nazar Kopeika on 18.06.2023.
//

import UIKit
import SafariServices

final class SearchNewsViewController: UIViewController {
    
    private let searchTable: UITableView = {
       let table = UITableView()
        table.register(NewsTableViewCell.self,
                       forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    let searchVC = UISearchController(searchResultsController: nil)
    
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [NewsTitlesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        navigationController?.navigationBar.barTintColor = .green
        view.addSubview(searchTable)
        searchTable.backgroundColor = UIColor(named: "background")
        
        searchTable.delegate = self
        searchTable.dataSource = self
        
        createSearchBar()
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func createSearchBar() {
//        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        searchVC.searchBar.placeholder = "Search for news..."
        searchVC.searchBar.searchBarStyle = .minimal
        
//        searchVC.searchBar.delegate = self
//            searchVC.searchBar.placeholder = "Search for news..."
//            searchVC.searchBar.searchBarStyle = .minimal
//            searchVC.searchBar.autocapitalizationType = .none
//            searchVC.searchBar.autocorrectionType = .no
//            searchVC.searchBar.spellCheckingType = .no
            
            // Set the UISearchBar as the tableHeaderView
            searchTable.tableHeaderView = searchVC.searchBar
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTable.frame = view.bounds
        
    }
}

extension SearchNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.backgroundColor = UIColor(named: "cellbackground")
        cell.selectionStyle = .none
        cell.configure(with: viewModels[indexPath.section])
        return cell
    }
}

extension SearchNewsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        NewsAPICaller.shared.searchNews(with: text) { [weak self] result in
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
                    self?.searchTable.reloadData()
                    self?.searchVC.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
