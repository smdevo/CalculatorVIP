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
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 2  // Limit decimal places
        formatter.exponentSymbol = "e"
        
        
        if let sciString = formatter.string(from: self as NSDecimalNumber) {
            return sciString  // Output: "1.23e+19"
        }
        
        return self.description
        
    }
   
}
