//
//  HomeWorker.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//
import Foundation


protocol HomeWorkerProtocol {
    func processResultAndAddHistoryIfNeeded(label: String, labelBtn: CButton) -> (String?,[Calculation]?)
    func fetchHistory() -> [Calculation]
    func deleteCalculation(indexPath: Int, items: [Calculation])
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
    
    func processResultAndAddHistoryIfNeeded(label: String, labelBtn: CButton) -> (String?,[Calculation]?) {
                
        if labelBtn == .equal {
            let resultLabel: (res: String?, expr: String?) = rpnCalculatorService.calculateAndGiveTheResult(calcLabel: label)
           
            guard
                let res = resultLabel.res,
                let exp = resultLabel.expr
            else {return (nil,nil)}
            
            historyDataService.saveCalculation(calculationStr:  exp + " = " + res)
            
            let calculationsSaved =  historyDataService.fetchHistory()
            
            return (res, calculationsSaved)
            
        } else {
            
            let  result = inputSourceOfRpnService
                .addingBtnToLabel(label: label, labelBtn: labelBtn)
          
            return (result,nil)
        }

    }
    
    
    
    func deleteCalculation(indexPath: Int, items: [Calculation]) {
        historyDataService.removeCalculation(indexPath: indexPath, items: items)
    }
    
    
    
    func fetchHistory() -> [Calculation] {
        return historyDataService.fetchHistory()
    }
    
}

