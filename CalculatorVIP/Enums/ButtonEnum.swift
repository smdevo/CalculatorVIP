//
//  ButtonEnum.swift
//  CalculatorVIP
//
//  Created by Samandar on 17/03/25.
//

enum ButtonEnum {
    
    enum TypeBracket {
        case open
        case close
    }
    
    case AC
    case del
    case bracket(type: TypeBracket)
    
    case number(num: String)
}

let a = ButtonEnum.bracket(type: .open)



