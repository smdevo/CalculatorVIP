//
//  InfinixUseCase.swift
//  CalculatorVIP
//
//  Created by Samandar on 18/03/25.
//

import Foundation

protocol FromRawValueToInfixProtocol {
    func makingInfixFromRaw(rawValue: String) -> String
}

struct FromRawValueToInfinixUseCase: FromRawValueToInfixProtocol {
    
    ///From this      "5+4+((((((((("      to ->      "5+4"
    func makingInfixFromRaw(rawValue: String) -> String {
        let cleanStr    = cleanEnd(str: rawValue)
        let completeStr = addingNeededBrackets(str: cleanStr)
        return completeStr
    }
    
    private func cleanEnd(str: String) -> String {
        var newStr = str
        while Op.withDotOpBr.r.contains(newStr.last ?? "0") {
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



