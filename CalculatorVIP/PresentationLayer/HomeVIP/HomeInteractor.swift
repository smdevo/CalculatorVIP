//
//  HomeViewInteractor.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

import Foundation

protocol HomeInteractorProtocol {
    func onViewDidLoad()
    func addOrCalculateResult(label: String, labelBtn: CButton)
    func delateCalculation(indexPath: Int, items: [Calculation])
    func clearHistory()
    func askIfClearingHistory()
}

final class HomeInteractor {
    
    //MARK: Dependencies
    private let presenter: HomePresenterProtocol
    private let worker: HomeWorkerProtocol
    
    
    private var euqalB: Bool = true
    private var otherB: Bool = true
        
    init(presenter: HomePresenterProtocol, worker: HomeWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
}

extension HomeInteractor: HomeInteractorProtocol {
   
    
    func onViewDidLoad() {
        presenter.presentNumberPadStackView()
        fetchAndGiveHistoryToPresenter()
    }
    
    
    func addOrCalculateResult(label: String, labelBtn: CButton) {
        
        if labelBtn == .equal {
            if euqalB {
                  calculateAndAddToHistory(label: label)
                otherB = false
            }
            euqalB = false
        }else {
            
            if !Op.numbers.r.contains(labelBtn.r) {
                otherB = true
            }
            
            if label == Constants.undefined.rawValue {
                otherB = false
            }
                       
            if otherB {
                addButtonToLabel(label: label, labelBtn: labelBtn)
            }else {
                addButtonToLabel(label: "0", labelBtn: labelBtn)
                otherB = true
            }
                euqalB = true
            
        }
    }
    
    func delateCalculation(indexPath: Int, items: [Calculation]) {
        worker.deleteCalculation(indexPath: indexPath, items: items)
        fetchAndGiveHistoryToPresenter()
    }
    
    func clearHistory() {
        worker.clearHistory()
        fetchAndGiveHistoryToPresenter()
    }
    
    func askIfClearingHistory() {
        presenter.presentAlert()
    }
    
    private func addButtonToLabel(label: String, labelBtn: CButton) {
        
        guard let completeLabel = worker.addButtonLabel(label: label, labelBtn: labelBtn) else { return }
        presenter.presentResult(result: completeLabel)
        
    }
    
    private func calculateAndAddToHistory(label: String) {
        guard let resultLabel =  worker.calCulateAndSaveToHistory(label: label) else { return }
        
        presenter.presentResult(result: resultLabel)
        
        fetchAndGiveHistoryToPresenter()
    }
    
    private func fetchAndGiveHistoryToPresenter() {
        let calculations = worker.fetchHistory()
        presenter.presentHistory(calculations: calculations)
    }
    
}
