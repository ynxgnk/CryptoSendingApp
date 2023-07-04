//
//  APIResponse.swift
//  project
//
//  Created by Nazar Kopeika on 18.06.2023.
//

import Foundation

struct NewsAPIResponse: Codable {
    let articles: [NewsTitlesModel]
}

struct CryptoAPIResponse: Codable {
    let coins: [CryptoCoinModel]
}
