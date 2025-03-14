//
//  ForString.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

extension String {
    
    var withoutLastElement: String {
        return String(self.dropLast())
    }
    
    var withoutFirstElement: String {
        return String(self.dropFirst())
    }
    
}
