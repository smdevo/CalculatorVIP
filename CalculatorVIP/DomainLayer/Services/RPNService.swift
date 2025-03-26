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
        
        if onlyNumbers(str: calcLabel).count <= 1 {
            return (nil,nil)
        }
        
        print("\nRaw Value: \(calcLabel)\n")
        
        let infix = infixFromRawValueUseCase.makingInfixFromRaw(rawValue: calcLabel)
        print("Infinix: \(infix)\n")
        
        let postfix = infixToPostFix(infix)

        
        guard let calculatedResult = calculateRPN(postFix: postfix) else {
            return (Constants.undefined.rawValue,infix)
        }
        
        return (calculatedResult.formattedDecimal, infix)
    }
    
    
    
    private func infixToPostFix(_ expression: String) -> [String] {
        
        let arrElements = fromStringToArrayUseCase.fromStringToElementsOfArray(value: expression)
                
        let precedence: [String: Int] =
        [
            CButton.add.r: 1,
            CButton.minus.r: 1,
            CButton.multiply.r: 2,
            CButton.divide.r: 2
        ]
        
        var postFix = CustomStack<String>(identifier: "post Arr")
        var opers   = CustomStack<String>(identifier: "oper Arr")
        
        for element in arrElements {
            
            if Double(element) != nil {
                
                postFix.push(element)
                
            } else if Op.only.r.contains(element) {
                
                while
                    let last = opers.peek,
                    let lastPrec = precedence[last],
                    lastPrec >= precedence[element]!
                {
                    postFix.push(opers.pop()!)
                }
                
                opers.push(element)
                
            } else if
                element == CButton.openBr.r
            {
                opers.push(element)
            } else if
                element == CButton.closeBr.r
            {
                while
                    let last = opers.peek,
                    last != CButton.openBr.r
                {
                    postFix.push(opers.pop()!)
                }
                let _ = opers.pop()
            }
            
        }
        
        while let last = opers.pop() {
            postFix.push(last)
        }
        return postFix.allElements
    }
    
    private func calculateRPN(postFix: [String]) -> Decimal? {
        
        var customStack = CustomStack<Decimal>(identifier: "Calculation")
        
        for eachElement in postFix {
            
            if let number = Double(eachElement) {
                customStack.push(Decimal(number))
            }else {
                guard
                let last = customStack.pop(),
                let bLast = customStack.pop()
                else {
                    return nil
                }
                switch eachElement {
                case CButton.divide.r:
                    guard last != 0 else { return nil }
                    customStack.push(bLast / last)
                case CButton.multiply.r: customStack.push(bLast * last)
                case CButton.minus.r:    customStack.push(bLast - last)
                case CButton.add.r:      customStack.push(bLast + last)
                default: break
                }
            }
        }
        return customStack.peek
    }
    
    private func onlyNumbers(str: String) -> [String] {
        let operators = CharacterSet(charactersIn: Op.withBrs.r)
        let components = str.components(separatedBy: operators)
        return components.filter {!$0.isEmpty}
    }
    
}

