//
//  CryptoTableViewCellViewModel.swift
//  project
//
//  Created by Nazar Kopeika on 19.06.2023.
//

import Foundation

final class CryptoTableViewCellViewModel {
    let cryptoImageUrl: URL?
    let cryptoTitle: String
    let cryptoSubtitle: String
    let cryptoPrice: String
    var cryptoImageData: Data? = nil
    let cryptoPercent: Double
    
    init(cryptoImageUrl: URL?, cryptoTitle: String, cryptoSubtitle: String, cryptoPrice: String, cryptoPercent: Double) {
        self.cryptoImageUrl = cryptoImageUrl
        self.cryptoTitle = cryptoTitle
        self.cryptoSubtitle = cryptoSubtitle
        self.cryptoPrice = cryptoPrice
        self.cryptoPercent =  cryptoPercent
    }
}
