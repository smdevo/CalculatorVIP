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
    
    
   private let infinixUseCase = FromRawValueToInfinixUseCase()
    
    
    
    func calculate(calcLabel: String) -> String {
        
        if extractingComponents(str: calcLabel).count == 1 {
            print("First \(calcLabel)")
            return calcLabel
        }

        let infinix = infinixUseCase.makingInfinixFromRaw(rawValue: calcLabel)
        
        print("Infinix: \(infinix)")
        
        let postfix = infinixToPostFix(infinix)
        print("Postfix: \(postfix)")
        
        guard let calculatedResult = calculateRPN(postFix: postfix) else {
            return "Undefined"
        }
        print("Result: \(calculatedResult)")
        
        
        return calculatedResult.stringForm
        
    }
    
    
    
    func infinixToPostFix(_ expression: String) -> [String] {
        
        let tokens = expression.strToElementsOfArray
        
        print("Tokens \(tokens)")
        
        
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
        
        print("Output \(output)")
        
        
        return output.map({$0.filter({$0 != " "})})
    }
    
    
    func calculateRPN(postFix: [String]) -> Float? {
        
        var customStack = CustomStack<Float>()
        
        for eachElement in postFix {
            
            if let number = Float(eachElement) {
                customStack.push(element: number)
            }
            
            if "÷×－+".contains(eachElement) {
                guard
                    let lastElemen = customStack.pop(),
                    let beforelastElement = customStack.pop()
                else {
                    continue
                }
                guard let newElement = calc(o: beforelastElement, t: lastElemen, e: eachElement) else {
                    return nil
                }
                customStack.push(element: newElement)
            }
            
        }
        
        return customStack.result
    }
    
    func calc(o: Float, t: Float,e: String) -> Float? {
        switch e {
        case "÷":
            if t == 0 {
                return nil
            }
            return o / t
        case "×": return o * t
        case "－": return o - t
        case "+": return o + t
        default: return 0
        }
    }
    
    private func extractingComponents(str: String) -> [String] {
        let operators = CharacterSet(charactersIn: "÷×－+")
        let components = str.components(separatedBy: operators)
        return components.filter {!$0.isEmpty}
    }
    
}

