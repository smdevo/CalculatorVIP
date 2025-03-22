//
//  HomeViewInteractor.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

import Foundation

protocol HomeInteractorProtocol {
    func onViewDidLoad()
    func processResult(label: String, labelBtn: CButton)
    func didChangedOrientation(to orientation: CalculatorOrientation)
    func fetchHistory()
    func deleteCalculation(indexPath: Int, items: [Calculation])
   // func addHistory()
}

final class HomeInteractor {
    
    //MARK: Dependencies
    private let presenter: HomePresenterProtocol
    private let worker: HomeWorkerProtocol
    
    //MARK: - Init
    
    init(presenter: HomePresenterProtocol, worker: HomeWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
}

extension HomeInteractor: HomeInteractorProtocol {
    
    
    func deleteCalculation(indexPath: Int, items: [Calculation]) {
        worker.deleteCalculation(indexPath: indexPath, items: items)
        
        let resultAfterDeeletion = worker.fetchHistory()
        
        presenter.presentHistory(calculations: resultAfterDeeletion)
    }

    
    func fetchHistory() {
        let calculations = worker.fetchHistory()
        
        presenter.presentHistory(calculations: calculations)
    }
    
    
    func onViewDidLoad() {
        presenter.setNumberPadStackView()
        
        fetchHistory()
    }
        
    func processResult(label: String, labelBtn: CButton) {
        
        //print("Processing inside the interactor")
        
        var resultLabel: (String?,String?)
        
        if labelBtn == .equal {
            resultLabel = worker.calculateTheResult(label: label)
            
            guard
                let res = resultLabel.0,
                let exp = resultLabel.1
            else {return}
            
            worker.addHistory(expression: exp + " = " + res)
            
            let calculationsSaved =  worker.fetchHistory()
            
            presenter.presentHistory(calculations: calculationsSaved)
            
        }else {
            resultLabel = (worker.addingBtnToLabel(label: label, labelBtn: labelBtn),nil)
        }
          
        guard
            let result = resultLabel.0
        else {return}
        
        presenter.presentResult(result: result, expression: resultLabel.1)
        
    }
    
    func didChangedOrientation(to orientation: CalculatorOrientation) {
        presenter.changeCalculatorPosition(to: orientation)
    }
}
