//
//  HomeWorker.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//
import Foundation


protocol HomeWorkerProtocol {
    func addingBtnToLabel(label: String, labelBtn: String) -> String
    func calculateTheResult(label: String) -> String
}


final class HomeWorker {
  
    let rpnCalculatorService: RPNServiceProtocol
    
    
    init(rpnCalculatorService: RPNServiceProtocol) {
        self.rpnCalculatorService = rpnCalculatorService
    }
}


extension HomeWorker: HomeWorkerProtocol {
    
    func addingBtnToLabel(label: String, labelBtn: String) -> String {
                
        guard let lastElement = label.last else {return label}
        
        switch labelBtn {
            
      //1
        case "AC":
            return "0"
            
            
      //2
        case "⌫":
            return label.count == 1 ? "0" : label.withoutLastElement
            
       //3
        case "(":
            if label == "0" {
                return "("
            }
            
            if lastElement == "," {
                return label.withoutLastElement + "×("
            }
            
            if lastElement.isNumber || lastElement == ")" {
                return label + "×("
            }
            return label + "("
            
            
        //4
        case ")":
            
            if !checkingForCloseTheBracket(str: label) {
                return label
            }
            
            if lastElement == "(" {
                return label
            }
            
            if
                "÷×－+,".contains(lastElement) {
                return label.withoutLastElement + ")"
            }
            
            return label + ")"
            
        //5
        case "÷", "×", "－", "+":
            
            if lastElement == "(" {return label}
            
            if "÷×－+,".contains(lastElement) {
                return label.withoutLastElement + labelBtn
            }
            
            return label + labelBtn
            
            
            
        //6
        case ",":
            
            if "÷×－+(".contains(lastElement) {return label + "0,"}
            
            if lastElement == ")" {return label + "×0,"}
            
            if let lastNumber = gettingLastNumber(str: label), lastNumber.contains(",") {return label}
            
            return label + ","
            
            
        //7
        default:
            
            if label == "0" { return labelBtn }
            
            
            // Case 2: Prevent multiple leading zeros in a number (e.g., "0000,82")
            if
                let lastNumber = gettingLastNumber(str: label),
                lastNumber == "0"
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
     
    func calculateTheResult(label: String) -> String {
         
         return "Calculate"
     }
    
    
    //private functions
    
    private func checkingForCloseTheBracket(str: String) -> Bool {
        
        var numberOfOpen = 0
        var numberOfClosed = 0
        
        str.forEach { char in
            if char == "(" {
                numberOfOpen += 1
            }
            if char == ")" {
                numberOfClosed += 1
            }
        }
        
        return numberOfOpen > numberOfClosed
    }
    
    
    private func gettingLastNumber(str: String) -> String? {
        let operators = CharacterSet(charactersIn: "÷×－+()")
        let components = str.components(separatedBy: operators)
        let cleanComps = components.filter({!$0.isEmpty})
        print(cleanComps)
        return cleanComps.last
    }
    
}

