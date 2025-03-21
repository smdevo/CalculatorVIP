//
//  HomeWorker.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//
import Foundation


protocol HomeWorkerProtocol {
    func addingBtnToLabel(label: String, labelBtn: CButton) -> String?
    func calculateTheResult(label: String) -> (String?, String?)
    func fetchHistory() -> [Calculation]
}


final class HomeWorker {
    let rpnCalculatorService: RPNServiceProtocol
    let inputSourceOfRpnService: InputSourceServiceProtocol
    let historyDataService: HistoryDataServiseProtocol
    
    
    init(rpnCalculatorService: RPNServiceProtocol, inputSourceOfRpnService: InputSourceServiceProtocol, historyDataService: HistoryDataServiseProtocol) {
        self.rpnCalculatorService = rpnCalculatorService
        self.inputSourceOfRpnService = inputSourceOfRpnService
        self.historyDataService = historyDataService
    }
}


extension HomeWorker: HomeWorkerProtocol {
    
    func fetchHistory() -> [Calculation] {
        return historyDataService.fetchHistory()
    }
    
    func addingBtnToLabel(label: String, labelBtn: CButton) -> String? {
        inputSourceOfRpnService.addingBtnToLabel(label: label, labelBtn: labelBtn)
    }
    
    func calculateTheResult(label: String) -> (String?, String?) {
        rpnCalculatorService.calculateAndGiveTheResult(calcLabel: label)
    }
}

// understanding
// need to testng
// nma ma'no
