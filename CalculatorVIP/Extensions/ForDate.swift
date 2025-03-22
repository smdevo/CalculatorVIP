//
//  ForDate.swift
//  CalculatorVIP
//
//  Created by Samandar on 22/03/25.
//

import Foundation

extension Date {
    func formattedString(
        format: String = "yyyy/MM/dd HH:mm:ss",
        timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        return formatter.string(from: self)
    }
    
    var settedFormat: String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy  HH:mm"
        formatter.timeZone = .current
        return formatter.string(from: self)
        
    }
    
}
