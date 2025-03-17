//
//  RPNService.swift
//  CalculatorVIP
//
//  Created by Samandar on 14/03/25.
//

import Foundation

protocol RPNServiceProtocol {
    func calculate(calcLabel: String) -> String
}


final class RPNService: RPNServiceProtocol {
    
    func calculate(calcLabel: String) -> String {
        
        let infinix = makingInfinixFromRaw(str: calcLabel)
        
        print("Infinix: \(infinix)")
        
        let postfix = infinixToPostFix(infinix)
        print("Postfix: \(postfix)")
        
        return postfix.debugDescription// + "Calculate"
        
    }
    


    func infinixToPostFix(_ expression: String) -> [String] {
        
        let tokens = strToStrArray(str: expression)
        
        print("Tokens \(tokens)")
        
        //let tokens = expression.components(separatedBy: "+－").filter { !$0.isEmpty }
        //print(tokens)
       // let precedence: [Character: Int] = ["+": 1, "-": 1, "*": 2, "/": 2]
        let precedence: [String: Int] = ["+": 1, "－": 1, "×": 2, "÷": 2]
        var output: [String] = [], stack: [String] = []
        
        for token in tokens {
            
            if let _ = Double(token) {
                output.append("\(token) ") // Son bo‘lsa chiqishga yozamiz
            } else if let _ = precedence[token] {
                while let last = stack.last, let lastPrec = precedence[last], lastPrec >= precedence[token]! {
                    output.append("\(stack.popLast()!) ")
                }
                stack.append(token) // Operatorni stack ga qo‘shamiz
            } else if token == "(" {
                stack.append(token) // Ochuvchi qavsni stack ga qo‘shamiz
            } else if token == ")" {
                while let last = stack.last, last != "(" {
                    output.append("\(stack.popLast()!) ")
                }
               let _ = stack.popLast() // Ochuvchi qavsni olib tashlaymiz
            }
        }
        
        while let last = stack.popLast() {
            output.append("\(last) ")
        }
        
        
       // let res = output.trimmingCharacters(in: .whitespaces)
        
        print(output)
        
        return output
    }

    
    // it should be Provider which contains one public 2 private funcitons
    private  func makingInfinixFromRaw(str: String) -> String {
        
        if extractingComponents(str: str).count == 1 {
            print("First \(str)")
            return str
        }
        
        let cleanStr    = removingAdditionalBrackets(str: str)
 
        let completeStr = addingNeededBrackets(str: cleanStr)
        
       
        print("Second \(completeStr)")
        return completeStr
    }
    
   
    //Helper functions

    /// This function makes string ,,, `jjjjjj`
    /// parametres: str: String
    private func removingAdditionalBrackets(str: String) -> String {
        var newStr = str
        
        while "÷×－+(.".contains(newStr.last ?? "0") { // "÷×－+(" dont contain 0 so it will leave
            newStr = newStr.withoutLastElement
        }
        
        while "÷×－+(".contains(newStr.first ?? "0") {
            newStr = newStr.withoutFirstElement
        }
        
        return newStr.isEmpty ? "0" : newStr
    }
    
    private func addingNeededBrackets(str: String) -> String {
        
        var newStr = str
                
        let openCount = newStr.filter({$0 == "("}).count
        let closeCount = newStr.filter({$0 == ")"}).count
        
        let isMoreOpen = openCount > closeCount
        
        let difference = abs(openCount - closeCount)
    
        let bracketsNeeded = String(Array(repeating: isMoreOpen ? ")" : "(", count: difference))
        
        newStr = isMoreOpen ? newStr + bracketsNeeded : bracketsNeeded + newStr
            
        return newStr
    }
    
    private func extractingComponents(str: String) -> [String] {
        let operators = CharacterSet(charactersIn: "÷×－+()")
        let components = str.components(separatedBy: operators)
        return components.filter {!$0.isEmpty}
    }
    
    private func strToStrArray(str: String) -> [String] {
        
        var strArr: [String] = []
        
        var num = ""
        
        for e in str {
            if e.isNumber || e == "." {
                num.append(e)
            }else if "÷×－+)".contains(e) {
                strArr.append(num)
                strArr.append(String(e))
                num = ""
            }else {
                strArr.append(String(e))
            }
        }
        
        strArr.append(num)
        
        return strArr.filter({!$0.isEmpty})
    }

}
