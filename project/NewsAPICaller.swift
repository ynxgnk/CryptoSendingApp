//
//  APICaller.swift
//  project
//
//  Created by Nazar Kopeika on 17.06.2023.
//

import Foundation

final class NewsAPICaller {
    static let shared = NewsAPICaller()
    
    struct Constants {
        static let NewsAPIKey = "7be67da124e64c6e957a0a1df0fb8f21"
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=US&apiKey=\(NewsAPIKey)")
        static let searchUrlString = "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=\(NewsAPIKey)&q="
    }
    
    private init() {}
    
    public func getTopNews(completion: @escaping (Result<[NewsTitlesModel], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data , _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
                    //                    print(result.articles.count)
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func searchNews(with query: String, completion: @escaping (Result<[NewsTitlesModel], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let urlString = Constants.searchUrlString + query
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data , _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
}
