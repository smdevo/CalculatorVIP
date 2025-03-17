//
//  TR2.swift
//  CalculatorVIP
//
//  Created by Samandar on 13/03/25.
//

import UIKit

class Trash2: UIViewController {
    
    
    override func viewDidLoad() {
       let _ = makingInfinixFromRaw(str: "((5+((((5+3)+(")//(((((1,0+(29×(4÷8))×43)+5)×(7+4)+3))+
    
    }
    
    
    func makingInfinixFromRaw(str: String) -> String {
        
        
        if extractingComponents(str: str).count == 1 {
            print("First \(str)")
            return str
        }
        
        let cleanStr    = removingAdditionalBrackets(str: str)
 
        let completeStr = addingNeededBrackets(str: cleanStr)
        
       
        print("Second \(completeStr)")
        return completeStr
    }
    
    
    private func extractingComponents(str: String) -> [String] {
        let operators = CharacterSet(charactersIn: "÷×－+()")
        let components = str.components(separatedBy: operators)
        return components.filter {!$0.isEmpty}
    }
   
    private func removingAdditionalBrackets(str: String) -> String {
        var newStr = str
        
        while "÷×－+(".contains(newStr.last ?? "0") { // "÷×－+(" dont contain 0 so it will leave
            newStr = newStr.withoutLastElement
        }
        
        while "÷×－+(".contains(newStr.first ?? "0") {
            newStr = newStr.withoutFirstElement
        }
        
        return newStr
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

}








