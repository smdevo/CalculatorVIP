//
//  ForDate.swift
//  CalculatorVIP
//
//  Created by Samandar on 22/03/25.
//

import Foundation

extension Date {
    
    var settedFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy  HH:mm"
        formatter.timeZone = .current
        return formatter.string(from: self)
        
    }
    
}
