//
//  RPNService.swift
//  CalculatorVIP
//
//  Created by Samandar on 14/03/25.
//

import Foundation

protocol RPNServiceProtocol {
    func calculateAndGiveTheResult(calcLabel: String) -> String?
}


final class RPNService: RPNServiceProtocol {
    
    
   private let infinixUseCase = FromRawValueToInfinixUseCase()
    
    func calculateAndGiveTheResult(calcLabel: String) -> String? {
        
        if extractingComponents(str: calcLabel).count == 1 {
            print("First \(calcLabel)")
            return nil
        }

        let infinix = infinixUseCase.makingInfinixFromRaw(rawValue: calcLabel)
        
        print("Infinix: \(infinix)")
        
        let postfix = infinixToPostFix(infinix)
        print("Postfix: \(postfix)")
        
        guard let calculatedResult = calculateRPN(postFix: postfix) else {
            return "Undefined"
        }
        
        let roundedResult = round(calculatedResult*1e5)/1e5

        return roundedResult.stringForm
        
    }
    
    
    
    private func infinixToPostFix(_ expression: String) -> [String] {
        
        let tokens = expression.strToElementsOfArray
        
        print("Tokens \(tokens)")
        
        
        let precedence: [String: Int] = ["+": 1, "－": 1, "×": 2, "÷": 2]
        var output: [String] = [], stack: [String] = []
        
        for token in tokens {
            
            if let _ = Double(token) {
                output.append("\(token)") // Son bo‘lsa chiqishga yozamiz
            } else if let _ = precedence[token] {
                while let last = stack.last, let lastPrec = precedence[last], lastPrec >= precedence[token]! {
                    output.append("\(stack.popLast()!)")
                }
                stack.append(token) // Operatorni stack ga qo‘shamiz
            } else if token == "(" {
                stack.append(token) // Ochuvchi qavsni stack ga qo‘shamiz
            } else if token == ")" {
                while let last = stack.last, last != "(" {
                    output.append("\(stack.popLast()!)")
                }
                let _ = stack.popLast() // Ochuvchi qavsni olib tashlaymiz
            }
        }
        
        while let last = stack.popLast() {
            output.append("\(last)")
        }
        
        
        return output
    }
    
    private func calculateRPN(postFix: [String]) -> Double? {
        
        var customStack = CustomStack<Double>()
        
        for eachElement in postFix {
            
            if let number = Double(eachElement) {
                customStack.push(element: number)
            }else {
                guard
                let last = customStack.pop(),
                let bLast = customStack.pop()
                else {
                    return nil
                }
                switch eachElement {
                case "÷": customStack.push(element: bLast / last)
                case "×": customStack.push(element: bLast * last)
                case "－":customStack.push(element: bLast - last)
                case "+":customStack.push(element: bLast + last)
                default: break
                }
            }
        }
        return customStack.result
    }
    
    private func math(last: Double, beforeLast: Double, oper: String) -> Double? {
        switch oper {
        case "÷": return beforeLast / last
//            if last == 0 {return nil}
//            return beforeLast / last
        case "×": return beforeLast * last
        case "－": return beforeLast - last
        case "+": return beforeLast + last
        default: return 0
        }
    }
    
    private func extractingComponents(str: String) -> [String] {
        let operators = CharacterSet(charactersIn: "÷×－+")
        let components = str.components(separatedBy: operators)
        return components.filter {!$0.isEmpty}
    }
    
}

