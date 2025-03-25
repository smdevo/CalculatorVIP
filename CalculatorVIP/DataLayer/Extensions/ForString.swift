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
    
    var strToElementsOfArray: [String] {
        var strArr: [String] = []
        var number = ""
        let operators = Op.withClBr.r
        
        
        if let first = self.first {
            if first == "-" {
                strArr.append("0")
            }
        }
        
        var oneBeforeEl: Character? = nil
        
        for char in self {
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

