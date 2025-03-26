//
//  InputSourceService.swift
//  CalculatorVIP
//
//  Created by Samandar on 17/03/25.
//

import Foundation

protocol InputSourceServiceProtocol {
    func addingBtnToLabel(label: String, labelBtn: CButton) -> String?
}


final class InputSourceService: InputSourceServiceProtocol {
    
    func addingBtnToLabel(label: String, labelBtn: CButton) -> String? {
        
        typealias B = CButton
        
        guard let lastChar = label.last else { return nil }
        let lastElement = lastChar.intoString
        switch labelBtn {
            
        case .clear:
            return  B.zero.r
            
            
        case .delete:
            return label.count == 1 ? B.zero.r : label.withoutLastElement
            
            
        case .openBr:
            
            if label == B.minus.r {
                return B.openBr.r
            }
            
            if label == B.zero.r {
                return B.openBr.r
            }
            
            if lastElement == B.dot.r {
                return label.withoutLastElement + B.multiply.r + B.openBr.r
            }
            
            if lastChar.isNumber || lastElement == B.closeBr.r {
                return label + B.multiply.r + B.openBr.r
            }
            return label + B.openBr.r
            
            
        case .closeBr:
            
            if !checkingForCloseTheBracket(str: label) {
                return nil
            }
            
            if lastElement == B.openBr.r {
                return nil
            }
            
            if
                Op.withDot.r.contains(lastElement) {
                
                if (label.withoutLastElement.last ?? "0").intoString == B.openBr.r {
                    return label.withoutLastElement
                }
                return label.withoutLastElement + B.closeBr.r
            }
            
            return label + B.closeBr.r
            
            
        case .add, .multiply, .divide:
            
            if lastElement == B.openBr.r {return nil}
            
            if label == B.minus.r {
                return B.zero.r
            }
            
            if Op.withDot.r.contains(lastElement) {
                
                if (label.withoutLastElement.last ?? "0").intoString == B.openBr.r {
                    return label.withoutLastElement
                }
                
                return label.withoutLastElement + labelBtn.r
            }
            
            return label + labelBtn.r
            
            
        case .minus:
            
            if label == B.zero.r {
                return B.minus.r
            }
            
            if Op.withDot.r.contains(lastElement) {
                if (label.withoutLastElement.last ?? "0").intoString == B.openBr.r {
                    return label.withoutLastElement
                }
                return label.withoutLastElement + labelBtn.r
            }
            
            return label + labelBtn.r
            
            
        case .dot:
            
            if Op.withOpBr.r.contains(lastElement) {return label + B.zero.r + B.dot.r}
            
            if lastElement == B.closeBr.r {
                return label + B.multiply.r + B.zero.r + B.dot.r
            }
            
            if let lastNumber = gettingLastNumber(str: label), lastNumber.contains(B.dot.r) {return nil}
            
            return label + B.dot.r
            
            
        default:
            
            if label == B.zero.r { return labelBtn.r }
            
            if
                let lastNumber = gettingLastNumber(str: label),
                lastNumber == B.zero.r && !Op.withBrs.r.contains(lastElement)
            {
                return label.withoutLastElement + labelBtn.r
            }
            
            if
                lastElement == B.closeBr.r  {
                return label + B.multiply.r + labelBtn.r
            }
            return label + labelBtn.r
        }
    }
    
    
    //private functions
    
    private func checkingForCloseTheBracket(str: String) -> Bool {
        return str.filter({String($0) == CButton.openBr.r}).count > str.filter({String($0) == CButton.closeBr.r}).count
    }
    
    
    private func gettingLastNumber(str: String) -> String? {
        let operators = CharacterSet(charactersIn: Op.withBrs.r)
        let components = str.components(separatedBy: operators)
        let cleanComps = components.filter({!$0.isEmpty})
        return cleanComps.last
    }
}
