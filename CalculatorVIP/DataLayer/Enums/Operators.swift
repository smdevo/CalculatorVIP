//
//  Operators.swift
//  CalculatorVIP
//
//  Created by Samandar on 20/03/25.
//

enum Op: String {
    
    case only         = "÷×-+"
    case withDot      = "÷×-+."
    case withDotOpBr  = "÷×-+.("
    case withDotClBr  = "÷×-+.)"
    case withOpBr     = "÷×-+("
    case withClBr     = "÷×-+)"
    case withBrs      = "÷×-+()"
    case all          = "÷×-+()."
    case numbers      = "0123456789"
    
    var r: String {
        rawValue
    }
}

