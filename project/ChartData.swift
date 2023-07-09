//
//  ChartData.swift
//  project
//
//  Created by Nazar Kopeika on 07.07.2023.
//

import Foundation

struct ChartData : Identifiable{ 
    let id = UUID().uuidString
    let date : Date
    let value : Double
}
