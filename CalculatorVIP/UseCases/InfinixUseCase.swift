//
//  InfinixUseCase.swift
//  CalculatorVIP
//
//  Created by Samandar on 18/03/25.
//

import Foundation

protocol FromRawValueToInfinixProtocol {
    func makingInfinixFromRaw(rawValue: String) -> String
}

struct FromRawValueToInfinixUseCase: FromRawValueToInfinixProtocol {
    
    func makingInfinixFromRaw(rawValue: String) -> String {
        
        if extractingComponents(str: rawValue).count == 1 {
            print("First \(rawValue)")
            return rawValue
        }
        
        let cleanStr    = removingAdditionalBrackets(str: rawValue)
 
        let completeStr = addingNeededBrackets(str: cleanStr)
        
       
        print("Second \(completeStr)")
        return completeStr
    }
    
    
    //Helper functions

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
    
    
}

