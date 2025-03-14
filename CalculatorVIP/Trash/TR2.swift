//
//  TR2.swift
//  CalculatorVIP
//
//  Created by Samandar on 13/03/25.
//

import UIKit

class Trash2: UIViewController {
    
    
    override func viewDidLoad() {
       let _ = convertToInfinix(str: "(5+((((5+3)")//(((((1,0+(29×(4÷8))×43)+5)×(7+4)+3))+
    
    }
    
    
    
    func secondConvert(str: String) {
        
        var normalStr: String = ""
        
        
        
        for el in normalStr {
            
            
            normalStr.append(el)
            
            
        }
        
        
        
    }
    
    func convertToInfinix(str: String) -> String {
        
        var newStr = str
        
        if extractingComponents(str: newStr).count == 1 {
            print("First \(newStr)")
            return newStr
        }
        
        print("First Count \(extractingComponents(str: newStr).count)")
        print(extractingComponents(str: newStr))

        
        while !(newStr.last ?? "0").isNumber {
            newStr = newStr.withoutLastElement
        }
        
        while !(newStr.first ?? "0").isNumber {
            newStr = newStr.withoutFirstElement
        }
    
        print("Second Count \(extractingComponents(str: newStr).count)")
        print(extractingComponents(str: newStr))
        
        if newStr.filter({$0 == ")"}).count > newStr.filter({$0 == "("}).count {
            
            let bracketsCount = newStr.filter({$0 == ")"}).count - newStr.filter({$0 == "("}).count
            
            let brackets = String(Array(repeating: "(", count: bracketsCount))
            
            newStr = brackets + newStr
            
        }else {
            let bracketsCount = newStr.filter({$0 == "("}).count - newStr.filter({$0 == ")"}).count
            
            let brackets = String(Array(repeating: ")", count: bracketsCount))
            
            newStr = newStr + brackets
        }
            
        print("Second \(newStr)")
        return newStr
    }
    
    
    private func extractingComponents(str: String) -> [String] {
        let operators = CharacterSet(charactersIn: "÷×－+()")
        let components = str.components(separatedBy: operators)
        return components.filter {!$0.isEmpty}
    }
   

}

