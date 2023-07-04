//
//  CryptoStatisticsModel.swift
//  project
//
//  Created by Nazar Kopeika on 19.06.2023.
//

import Foundation

struct CryptoStatisticsModel {
    let id = UUID().uuidString
    let title : String
    let value : String
    let percentageChange : Double? 
}
