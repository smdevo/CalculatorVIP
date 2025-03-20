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
        
        print("Raw Value \(rawValue)")
        let cleanStr    = cleanEnd(str: rawValue)
        let completeStr = addingNeededBrackets(str: cleanStr)
        return completeStr
    }
    
    
    //Helper functions

    private func cleanEnd(str: String) -> String {
        var newStr = str
        while "÷×－+(.".contains(newStr.last ?? "0") { // "÷×－+(" dont contain 0 so it will leave
            newStr = newStr.withoutLastElement
        }
        return newStr.isEmpty ? "0" : newStr
    }
    
    private func addingNeededBrackets(str: String) -> String {
        let differenceCount = str.filter({$0 == "("}).count - str.filter({$0 == ")"}).count
        let bracketsNeeded = String(Array(repeating: ")", count: differenceCount))
        return str + bracketsNeeded
    }
}



