//
//  RPNService.swift
//  CalculatorVIP
//
//  Created by Samandar on 14/03/25.
//

import Foundation


protocol RPNServiceProtocol {
    func calculateAndGiveTheResult(calcLabel: String) -> (String?, String?)
}


final class RPNService: RPNServiceProtocol {
    
    
    private let infixFromRawValueUseCase = FromRawValueToInfinixUseCase()
    private let fromStringToArrayUseCase = FromStringToArrayUseCase()
    
    func calculateAndGiveTheResult(calcLabel: String) -> (String?, String?) {
        
        if extractingComponents(str: calcLabel).count == 1 {
            print("First \(calcLabel)")
            return (nil,nil)
        }
        
        print("Raw Value: \(calcLabel)")
        
        let infix = infixFromRawValueUseCase.makingInfixFromRaw(rawValue: calcLabel)
        
        print("Infinix: \(infix)")
        
        let postfix = infinixToPostFix(infix)
        print("Postfix: \(postfix)")
        
        guard let calculatedResult = calculateRPN(postFix: postfix) else {
            return ("Undefined",infix)
        }
        
        return (calculatedResult.strDesc, infix)
    }
    
    
    
    private func infinixToPostFix(_ expression: String) -> [String] {
        
        let arrElements = fromStringToArrayUseCase.fromStringToElementsOfArray(value: expression)
                
        let precedence: [String: Int] =
        [CButton.add.r: 1, CButton.minus.r: 1, CButton.multiply.r: 2, CButton.divide.r: 2]
        var postFix = CustomStack<String>()
        var opers   = CustomStack<String>()
        
        for element in arrElements {
            
            if let _ = Double(element) {
                postFix.push(element: element)
            } else if let _ = precedence[element] {
                while let last = opers.peek(),
                        let lastPrec = precedence[last],
                        lastPrec >= precedence[element]!
                {
                    postFix.push(element: opers.pop()!)
                }
                opers.push(element: element) // Operatorni stack ga qo‘shamiz
            } else if element == "(" {
                opers.push(element: element) // Ochuvchi qavsni stack ga qo‘shamiz
            } else if element == ")" {
                while let last = opers.peek(), last != "(" {
                    postFix.push(element: opers.pop()!)//.append("\(stack.popLast()!)")
                }
                let _ = opers.pop()//.popLast() // Ochuvchi qavsni olib tashlaymiz
            }
        }
        
        while let last = opers.pop() {//.popLast() {
            postFix.push(element: last)//.append("\(last)")
        }
        
        
        return postFix.allElements()
    }
    
    private func calculateRPN(postFix: [String]) -> Decimal? {
        
        var customStack = CustomStack<Decimal>()
        
        for eachElement in postFix {
            
            if let number = Double(eachElement) {
                customStack.push(element: Decimal(number))
            }else {
                guard
                let last = customStack.pop(),
                let bLast = customStack.pop()
                else {
                    return nil
                }
                switch eachElement {
                case CButton.divide.r:   customStack.push(element: bLast / last)
                case CButton.multiply.r: customStack.push(element: bLast * last)
                case CButton.minus.r:    customStack.push(element: bLast - last)
                case CButton.add.r:      customStack.push(element: bLast + last)
                default: break
                }
            }
        }
        return customStack.peek()
    }
    
    private func extractingComponents(str: String) -> [String] {
        let operators = CharacterSet(charactersIn: Op.withBrs.r)
        let components = str.components(separatedBy: operators)
        return components.filter {!$0.isEmpty}
    }
    
}

