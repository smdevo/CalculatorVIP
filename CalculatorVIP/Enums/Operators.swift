//
//  Operators.swift
//  CalculatorVIP
//
//  Created by Samandar on 20/03/25.
//

enum Op: String {
    
    case only     = "÷×-+"
    case withDot  = "÷×-+."
    case withOpBr = "÷×-+("
    case withClBr = "÷×-+)"
    case withBrs  = "÷×-+()"
    case all      = "÷×-+()."
    
    
    var r: String {
        rawValue
    }
}



//－
