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
        
        let infinix = infinixUseCase.makingInfinixFromRaw(rawValue: calcLabel)
        
        print("Infinix: \(infinix)")
        
        let postfix = infinixToPostFix(infinix)
        print("Postfix: \(postfix)")
        
        let calculatedResult = calculateRPN(postFix: postfix)
        print("Result: \(calculatedResult)")
        
        var intResult: Int?
        
        if abs(calculatedResult) - Float(Int(abs(calculatedResult))) == 0 {
            intResult = Int(calculatedResult)
        }
        
        return intResult != nil ? String(intResult ?? 0) : String(calculatedResult)
        
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
    
    
    func calculateRPN(postFix: [String]) -> Float {
        
        var customStack = CustomStack()
        
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
                let newElement = calc(o: beforelastElement, t: lastElemen, e: eachElement)
                customStack.push(element: newElement)
            }
            
        }
        
        return customStack.result
    }
    
    func calc(o: Float, t: Float,e: String) -> Float {
        switch e {
        case "÷": return o / t
        case "×": return o * t
        case "－": return o - t
        case "+": return o + t
        default: return 0
        }
    }
}

//LIFO
/*
 1. Function Call Management
 When a function is called, its local variables, parameters, and return address are stored in the call stack.
 When the function completes, its data is removed from the stack.
 This allows for nested function calls and recursion to work properly.
 
 2. Efficient Memory Allocation
 The stack operates in a Last In, First Out (LIFO) manner, meaning the most recently added data is removed first.
 Memory allocation and deallocation on the stack are fast because they follow a simple push/pop operation.
 
 */
struct CustomStack {
    
   // let postFixElements: [String]
    
   private var elements: [Float] = []
    
    
    mutating func push(element: Float) {
        elements.append(element)
    }
    
    mutating func pop() -> Float? {
        guard !elements.isEmpty else {return nil}
        return elements.removeLast()
    }
    
    var result: Float {
        return elements.last ?? 0
    }
    
}


