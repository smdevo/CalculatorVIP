//
//  HomeViewInteractor.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

protocol HomeInteractorProtocol {
    func processResult(label: String, labelBtn: String)
}

final class HomeInteractor {
    
    //MARK: Dependencies
    private let presenter: HomePresenterProtocol
    private let worker = HomeWorker()
    
    //MARK: - Init
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }
    
}

extension HomeInteractor: HomeInteractorProtocol {
    
    
    func processResult(label: String, labelBtn: String) {
        
        print("Processing inside the interactor")
        
        let result = labelBtn == "=" ?
        worker.calculateTheResult(label: label, labelBtn: labelBtn) :
        worker.addingBtnToLabel(label: label, labelBtn: labelBtn)
    
        
        presenter.presentResult(result: result)
        
    }
    

    
}
