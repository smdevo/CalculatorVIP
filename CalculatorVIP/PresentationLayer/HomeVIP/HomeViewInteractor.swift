//
//  HomeViewInteractor.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

import Foundation

protocol HomeInteractorProtocol {
    func onViewDidLoad()
    func processResultAndHistory(label: String, labelBtn: CButton)
    func didChangedOrientation(to orientation: CalculatorOrientation)
    func deleteCalculation(indexPath: Int, items: [Calculation])
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
    
    func onViewDidLoad() {
        presenter.setNumberPadStackView()
        fetchHistory()
    }
    
    func processResultAndHistory(label: String, labelBtn: CButton) {
        
        let historywithResult = worker
            .processResultAndAddHistoryIfNeeded(label: label, labelBtn: labelBtn)
        
        guard let result = historywithResult.0 else {
            return
        }
        presenter.presentResult(result: result)
        
        guard let history = historywithResult.1 else {
            return
        }
        presenter.presentHistory(calculations: history)
        
    }
    
    func deleteCalculation(indexPath: Int, items: [Calculation]) {
        worker.deleteCalculation(indexPath: indexPath, items: items)
        let resultAfterDeeletion = worker.fetchHistory()
        presenter.presentHistory(calculations: resultAfterDeeletion)
    }
    
    func didChangedOrientation(to orientation: CalculatorOrientation) {
        presenter.changeCalculatorPosition(to: orientation)
    }
    
    private func fetchHistory() {
        let calculations = worker.fetchHistory()
        presenter.presentHistory(calculations: calculations)
    }
    
}
