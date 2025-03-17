//
//  RPNService.swift
//  CalculatorVIP
//
//  Created by Samandar on 14/03/25.
//

import Foundation

//protocol RPNServiceProtocol {
//    
//    func convertingTheLabelIntoRpnForm(_ rawlabel: String) -> String
//    
//    func calculate(_ rpnLabel: String) -> String
//}

final class RPNService {
    
    
    func calculate(calcLabel: String) -> String {
        
        let postfixLabel =  convertingTheLabelIntoRpnForm(rawlabel: calcLabel)
        
        
        
        return postfixLabel + "Calculate"
    }
    
    
    
    private func convertingTheLabelIntoRpnForm(rawlabel: String) -> String {
        return "Convert"
    }

}
