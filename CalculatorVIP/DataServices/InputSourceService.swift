//
//  InputSourceService.swift
//  CalculatorVIP
//
//  Created by Samandar on 17/03/25.
//

import Foundation

protocol InputSourceServiceProtocol {
    func addingBtnToLabel(label: String, labelBtn: String) -> String?
}


final class InputSourceService: InputSourceServiceProtocol {
    
    func addingBtnToLabel(label: String, labelBtn: String) -> String? {
                
        guard let lastElement = label.last else {return nil}
        
        switch labelBtn {
            
      //1
        case "AC":
            return labelBtn != "0" ? "0" : nil
            
            
      //2
        case "⌫":
            return label.count == 1 ? "0" : label.withoutLastElement
            
       //3
        case "(":
            if label == "0" {
                return "("
            }
            
            if lastElement == "." {
                return label.withoutLastElement + "×("
            }
            
            if lastElement.isNumber || lastElement == ")" {
                return label + "×("
            }
            return label + "("
            
            
        //4
        case ")":
            
            if !checkingForCloseTheBracket(str: label) {
                return nil
            }
            
            if lastElement == "(" {
                return nil
            }
            
            if
                "÷×－+.".contains(lastElement) {
                return label.withoutLastElement + ")"
            }
            
            return label + ")"
            
        //5
        case "÷", "×", "－", "+":
            
            if lastElement == "(" {return nil}
            
            if "÷×－+.".contains(lastElement) {
                return label.withoutLastElement + labelBtn
            }
            
            return label + labelBtn
            
            
            
        //6
        case ".":
            
            if "÷×－+(".contains(lastElement) {return label + "0."}
            
            if lastElement == ")" {return label + "×0."}
            
            if let lastNumber = gettingLastNumber(str: label), lastNumber.contains(".") {return nil}
            
            return label + "."
            
            
        //7
        default:
            
            if label == "0" { return labelBtn }
            
            if
                let lastNumber = gettingLastNumber(str: label),
                lastNumber == "0" && !"÷×－+".contains(lastElement)
            {
                return label.withoutLastElement + labelBtn
            }
            
            if
                lastElement == ")"  {
                return label + "×" + labelBtn
            }
            
            return label + labelBtn
        }
    }
    
    
    //private functions
    
    private func checkingForCloseTheBracket(str: String) -> Bool {
        return str.filter({$0 == "("}).count > str.filter({$0 == ")"}).count
    }
    
    
    private func gettingLastNumber(str: String) -> String? {
        let operators = CharacterSet(charactersIn: "÷×－+()")
        let components = str.components(separatedBy: operators)
        let cleanComps = components.filter({!$0.isEmpty})
  //      print(cleanComps)
        return cleanComps.last
    }
}




//protocol ZeroProviderProtocol
//
//struct ZeroProvider: ZeroProviderProtocol
