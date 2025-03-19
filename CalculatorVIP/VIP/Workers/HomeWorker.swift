//
//  HomeWorker.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//
import Foundation


protocol HomeWorkerProtocol {
    func addingBtnToLabel(label: String, labelBtn: String) -> String?
    func calculateTheResult(label: String) -> String?
}


final class HomeWorker {
    let rpnCalculatorService: RPNService
    let inputSourceOfRpnService: InputSourceService
    
    
    init(rpnCalculatorService: RPNService, inputSourceOfRpnService: InputSourceService) {
        self.rpnCalculatorService = rpnCalculatorService
        self.inputSourceOfRpnService = inputSourceOfRpnService
    }
}


extension HomeWorker: HomeWorkerProtocol {
    func addingBtnToLabel(label: String, labelBtn: String) -> String? {
        inputSourceOfRpnService.addingBtnToLabel(label: label, labelBtn: labelBtn)
    }
    
    func calculateTheResult(label: String) -> String? {
        rpnCalculatorService.calculateAndGiveTheResult(calcLabel: label)
    }
}

// understanding
// need to testng
// nma ma'no
