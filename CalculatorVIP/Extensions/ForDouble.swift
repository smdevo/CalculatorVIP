//
//  ForDouble.swift
//  CalculatorVIP
//
//  Created by Samandar on 19/03/25.
//
import Foundation

extension Double {
    
    var stringForm: String {
        if let intValue = Int(exactly: self) {
            return String(intValue)
        }
        return String(self).replacingOccurrences(of: "-", with: "－") //
    }
}
