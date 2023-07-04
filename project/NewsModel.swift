//
//  NewsModel.swift
//  project
//
//  Created by Nazar Kopeika on 18.06.2023.
//

import Foundation

// MARK: - Model
struct NewsTitlesModel: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let author: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
