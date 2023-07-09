//
//  StatisticModel.swift
//  project
//
//  Created by Nazar Kopeika on 07.07.2023.
//

import Foundation

struct StatiscticModel {
    
    let id: String
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double?) {
        self.id = UUID().uuidString
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
