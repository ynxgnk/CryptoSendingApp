//
//  NewsTableViewCellViewModel.swift
//  project
//
//  Created by Nazar Kopeika on 18.06.2023.
//

import Foundation

final class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let author: String?
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, author: String?, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.author = author
        self.imageURL = imageURL
    }
}
