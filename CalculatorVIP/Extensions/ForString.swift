//
//  ForString.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

extension String {
    
    var withoutLastElement: String {
        return String(self.dropLast())
    }
    
    var withoutFirstElement: String {
        return String(self.dropFirst())
    }
    
    var strToElementsOfArray: [String] {
        
        var strArr: [String] = []
        
        var num = ""
        
        for e in self {
            if e.isNumber || e == "." {
                num.append(e)
            }else if "÷×－+)".contains(e) {
                strArr.append(num)
                strArr.append(String(e))
                num = ""
            }else {
                strArr.append(String(e))
            }
        }
        
        strArr.append(num)
        
        return strArr.filter({!$0.isEmpty})
    }
    
}
