//
//  FromStringToArray.swift
//  CalculatorVIP
//
//  Created by Samandar on 25/03/25.
//

protocol FromStringToArrayProtocol {
    func fromStringToElementsOfArray(value: String) -> [String]
}


struct FromStringToArrayUseCase: FromStringToArrayProtocol {
    
    func fromStringToElementsOfArray(value: String) -> [String] {
        
        var strArr: [String] = []
        var number = ""
        let operators = Op.withClBr.r
        
        
        if let first = value.first {
            if first == "-" {
                strArr.append("0")
            }
        }
        
        var oneBeforeEl: Character? = nil
        
        for char in value {
            if char.isNumber || char == "." {
                number.append(char)
            } else {
                if !number.isEmpty {
                    strArr.append(number)
                    number = ""
                }
                if operators.contains(char) || !char.isWhitespace {
                    
                    if oneBeforeEl == "(" && char == "-" {
                        strArr.append("0")
                    }
                    
                    strArr.append(char.intoString)
                }
            }
            
            oneBeforeEl = char
        }
        
        if !number.isEmpty {
            strArr.append(number)
        }
        
        return strArr
    }

    
}

