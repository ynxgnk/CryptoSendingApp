//
//  CryptoDetailsCollectionViewCellViewModel.swift
//  project
//
//  Created by Nazar Kopeika on 08.07.2023.
//

import Foundation

final class CryptoDetailsCollectionViewCellViewModel {
    let currentPrice: String
    let currentPricePercentage: String
    
    let marketCapPrice: String
    let marketCapPercentage: String
    
    let rank: String
    let volume: String
    
    let high24: String
    let priceChange24: String
    let priceChange24Percentage: String
    
    let low24: String
    let marketCapChange: String
    let marketPriceChange24Percentage: String
    
    init(currentPrice: String, currentPricePercentage: String, marketCapPrice: String, marketCapPercentage: String, rank: String, volume: String, high24: String, priceChange24: String, priceChange24Percentage: String, low24: String, marketCapChange: String, marketPriceChange24Percentage: String) {
        self.currentPrice = currentPrice
        self.currentPricePercentage = currentPricePercentage
        self.marketCapPrice = marketCapPrice
        self.marketCapPercentage = marketCapPercentage
        self.rank = rank
        self.volume = volume
        self.high24 = high24
        self.priceChange24 = priceChange24
        self.priceChange24Percentage = priceChange24Percentage
        self.low24 = low24
        self.marketCapChange = marketCapChange
        self.marketPriceChange24Percentage = marketPriceChange24Percentage
    }
}
