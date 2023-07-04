//
//  NumberFormatter.swift
//  project
//
//  Created by Nazar Kopeika on 19.06.2023.
//

import Foundation

// number formatter
extension Double{
    
    private var currencyFormatter : NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2 // min and max digits
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    private var numberFormatter : NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2 // min and max digits
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toCurrency() -> String{
        return currencyFormatter.string(for: self) ?? "$0.00"
    }
    
    func toPercentageString() -> String{
        // in this case self references to the Double type
        guard let numberAsString = numberFormatter.string(for: self) else { return ""}
        return numberAsString + " %"
    }
     
    func asNumberString() -> String{
        return String(format: "%.2f", self)
    }
    
    func formattedWithAbbreviations() -> String{
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num{
        case 1000000000000...: // trillions
            let formatted = num / 1000000000000
//            print(num)
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()
        default:
            return "\(sign)\(self)"
        }
    }
    
}
