//
//  ButtonEnum.swift
//  CalculatorVIP
//
//  Created by Samandar on 17/03/25.
//
import UIKit

enum CButton: String {
    case zero = "0"
    case one = "1", two = "2", three = "3"
    case four = "4", five = "5", six = "6"
    case seven = "7", eight = "8", nine = "9"
    case openBr = "(", closeBr = ")"
    case add = "+", minus = "-", multiply = "×", divide = "÷"  //－
    case clear = "AC", delete = "⌫"
    case dot = "."
    case equal = "="
    
    
    

    var backgroundColor: UIColor {
        switch self {
        case .add, .minus, .multiply, .divide, .equal:
            return UIColor.theme.operatorColor
        case .clear, .openBr, .closeBr, .delete:
            return UIColor.theme.bracketColor
        default:
            return UIColor.theme.numberColor
        }
    }
    
    var r: String {
        rawValue
    }
}





