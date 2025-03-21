//
//  HomeViewInteractor.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//



protocol HomeInteractorProtocol {
    func onViewDidLoad()
    func processResult(label: String, labelBtn: CButton)
    func didChangedOrientation(to orientation: CalculatorOrientation)
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
    }
        
    func processResult(label: String, labelBtn: CButton) {
        
        //print("Processing inside the interactor")
        
        var resultLabel: (String?,String?)
        
        if labelBtn == .equal {
            resultLabel = worker.calculateTheResult(label: label)
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
