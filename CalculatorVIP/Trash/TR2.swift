//
//  TR2.swift
//  CalculatorVIP
//
//  Created by Samandar on 13/03/25.
//

import UIKit

class Trash2: UIViewController {
    
    
    override func viewDidLoad() {
       let _ = convertToRPNStr(str: "(12+9×(4－3))")
    }
    
    
    func convertToRPNStr(str: String) -> String {
        
        var newStr = str
        
        if extractingComponents(str: newStr).count == 1 {
            print("First \(newStr)")
            return newStr
        }
        
        print("Count \(extractingComponents(str: newStr).count)")
        print(extractingComponents(str: newStr))

        
        while !(newStr.last ?? "0").isNumber {
            newStr = newStr.withoutLastElement
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

