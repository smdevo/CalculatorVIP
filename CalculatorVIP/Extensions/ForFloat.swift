//
//  ForFloat.swift
//  CalculatorVIP
//
//  Created by Samandar on 18/03/25.
//


extension Float {
    
    var stringForm: String {
        
        var intResult: Int?
        
        if abs(self) - Float(Int(abs(self))) == 0 {
            intResult = Int(self)
        }
        
        return intResult != nil ? String(intResult ?? 0) : String(self)
    }
}
