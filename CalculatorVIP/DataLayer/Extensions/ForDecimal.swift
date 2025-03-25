//
//  ForDecimal.swift
//  CalculatorVIP
//
//  Created by Samandar on 25/03/25.
//

import Foundation

extension Decimal {
    
    var strDesc: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        if self.exponent >= 8 || self.exponent <= -8 {
            formatter.numberStyle = .scientific
            formatter.exponentSymbol = "e"
        }
        
        return formatter.string(from: self as NSDecimalNumber) ?? self.description
    }
}
