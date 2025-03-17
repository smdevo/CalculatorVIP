//
//  HomeViewInteractor.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

protocol HomeInteractorProtocol {
    func onViewDidLoad()
    func processResult(label: String, labelBtn: String)
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
    
    
    func processResult(label: String, labelBtn: String) {
        
        //print("Processing inside the interactor")
        //need to use if
        let result = labelBtn == "=" ?
        worker.calculateTheResult(label: label) :
        worker.addingBtnToLabel(label: label, labelBtn: labelBtn)
        
        presenter.presentResult(result: result)
        
    }
    

    
}
