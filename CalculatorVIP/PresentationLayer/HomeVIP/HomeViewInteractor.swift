//
//  HomeViewInteractor.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

import Foundation

protocol HomeInteractorProtocol {
    func onViewDidLoad()
    func addButtonToLabel(label: String, labelBtn: CButton)
    func calculateAndAddToHistory(label: String)
    func delateCalculation(indexPath: Int, items: [Calculation])
    func clearHistory()
}

final class HomeInteractor {
    
    //MARK: Dependencies
    private let presenter: HomePresenterProtocol
    private let worker: HomeWorkerProtocol
        
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
    
    func addButtonToLabel(label: String, labelBtn: CButton) {
        
        guard let completeLabel = worker.addButtonLabel(label: label, labelBtn: labelBtn) else {return}
        presenter.presentResult(result: completeLabel)
        
    }
    
    func calculateAndAddToHistory(label: String) {
        guard let resultLabel =  worker.calCulateAndSaveToHistory(label: label) else {return}
        
        presenter.presentResult(result: resultLabel)
        
        fetchAndGiveHistoryToPresenter()
    }
    
    
    func delateCalculation(indexPath: Int, items: [Calculation]) {
        worker.deleteCalculation(indexPath: indexPath, items: items)
        fetchAndGiveHistoryToPresenter()
    }
    
    func clearHistory() {
        worker.clearHistory()
        fetchAndGiveHistoryToPresenter()
    }
    
    
    private func fetchAndGiveHistoryToPresenter() {
        let calculations = worker.fetchHistory()
        presenter.presentHistory(calculations: calculations)
    }
    
}
