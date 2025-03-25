//
//  HomeWorker.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//
import Foundation


protocol HomeWorkerProtocol {
    
    func addButtonLabel(label: String, labelBtn: CButton) -> String?
    func calCulateAndSaveToHistory(label: String) -> String?
    func fetchHistory() -> [Calculation]
    func deleteCalculation(indexPath: Int, items: [Calculation])
    func clearHistory()
}


final class HomeWorker {
    let rpnCalculatorService: RPNServiceProtocol
    let inputSourceOfRpnService: InputSourceServiceProtocol
    let historyDataService: HistoryDataServiseProtocol
    
    
    init(
        rpnCalculatorService: RPNServiceProtocol,
        inputSourceOfRpnService: InputSourceServiceProtocol,
        historyDataService: HistoryDataServiseProtocol)
    {
        self.rpnCalculatorService = rpnCalculatorService
        self.inputSourceOfRpnService = inputSourceOfRpnService
        self.historyDataService = historyDataService
    }
}


extension HomeWorker: HomeWorkerProtocol {
    
    func addButtonLabel(label: String, labelBtn: CButton) -> String? {
        let  result = inputSourceOfRpnService
            .addingBtnToLabel(label: label, labelBtn: labelBtn)
        
        return result
    }
    
    func calCulateAndSaveToHistory(label: String) -> String? {
        
        let result: (outcome: String?, clearExpression: String?) = rpnCalculatorService.calculateAndGiveTheResult(calcLabel: label)
        guard
            let res = result.outcome,
            let exp = result.clearExpression
        else {return nil}
        
        historyDataService.saveCalculation(calculationStr:  exp + " = " + res)
        
        return res
    }
    
    func fetchHistory() -> [Calculation] {
        return historyDataService.fetchHistory()
    }
    
    func deleteCalculation(indexPath: Int, items: [Calculation]) {
        historyDataService.removeCalculation(indexPath: indexPath, items: items)
    }
    
    func clearHistory() {
        historyDataService.clearHistory()
    }
    
}

