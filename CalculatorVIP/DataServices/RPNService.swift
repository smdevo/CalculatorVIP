//
//  RPNService.swift
//  CalculatorVIP
//
//  Created by Samandar on 14/03/25.
//

import Foundation

protocol RPNServiceProtocol {
    
    func convertingTheLabelIntoRpnForm(_ rawlabel: String) -> String
    
    func calculate(_ rpnLabel: String) -> String
}

final class RPNService: RPNServiceProtocol {
    
    func convertingTheLabelIntoRpnForm(_ rawlabel: String) -> String {
        return "Convert"
    }
    
    func calculate(_ rpnLabel: String) -> String {
        return "Calculate"
    }
    
    
    
    
}
