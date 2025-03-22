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
        
        var newArr: [String] = []
        
        if let first = strArr.first {
            
            if first == "-" {
                newArr.append("0")
            }
            
            newArr.append(first)
        }
        
        for i in 0..<strArr.count - 1 {
            
            if strArr[i] == "(" && strArr[i+1] == "-" {
                newArr.append("0")
            }
            
            newArr.append(strArr[i+1])
        }
        
        print("New arr \(newArr)")
        
        return newArr
    }
    
}

