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
        let operators = "÷×－+)"
        
        for char in self {
            if char.isNumber || char == "." {
                number.append(char)
            } else {
                if !number.isEmpty {
                    strArr.append(number)
                    number = ""
                }
                if operators.contains(char) || !char.isWhitespace {
                    strArr.append(char.intoString)
                }
            }
        }
        
        if !number.isEmpty {
            strArr.append(number)
        }
        
        return strArr
    }
}

