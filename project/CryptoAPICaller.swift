//
//  CryptoAPICaller.swift
//  project
//
//  Created by Nazar Kopeika on 19.06.2023.
//

import Foundation

final class CryptoAPICaller {
    static let shared = CryptoAPICaller()
    
    struct Constants {
        static let API_URL = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=true&price_change_percentage=24h")
        static let API_DETAILS_URL = URL(string: "https://api.coingecko.com/api/v3/coins/")
    }
    
    private init() {}
    
    private var isLoadingData = false
    
    public func fetchCryptoData(completion: @escaping (Result<[CryptoCoinModel], Error>) -> Void) {
        guard let url = Constants.API_URL else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data , _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    var coins = try JSONDecoder().decode([CryptoCoinModel].self, from: data)
                    
                    for (index, coin) in coins.enumerated() {
                        if let imageURL = URL(string: coin.image) {
                            let imageData = try Data(contentsOf: imageURL)
                            coins[index].cryptoImageData = imageData
                        }
                    }
                    completion(.success(coins))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }

    public func fetchCryptoDetailsData(for coinId: String, completion: @escaping (Result<CryptoCoinModel, Error>) -> Void) {
        let urlString = "\(Constants.API_DETAILS_URL)\(coinId)"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let coin = try JSONDecoder().decode(CryptoCoinModel.self, from: data)
                    completion(.success(coin))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }



    
}
