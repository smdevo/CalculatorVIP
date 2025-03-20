//
//  ButtonEnum.swift
//  CalculatorVIP
//
//  Created by Samandar on 17/03/25.
//
import UIKit

enum Button: String {
    case zero = "0"
    case one = "1", two = "2", three = "3"
    case four = "4", five = "5", six = "6"
    case seven = "7", eight = "8", nine = "9"
    case openBr = "(", closeBr = ")"
    case add = "+", subtract = "-", multiply = "×", divide = "÷"
    case clear = "AC", delete = "⌫"
    case decimal = "."
    case equal = "="
   

    var backgroundColor: UIColor {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .openBr, .closeBr, .delete:
            return .lightGray
        default:
            return .darkGray
        }
    }
}



