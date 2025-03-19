//
//  HomeViewInteractor.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

enum CalculatorOrientation {
    case landscale
    case portrait
}

protocol HomeInteractorProtocol {
    func onViewDidLoad()
    func processResult(label: String, labelBtn: String)
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
        
    func processResult(label: String, labelBtn: String) {
        
        //print("Processing inside the interactor")
        
        var resultLabel: String?
        
        if labelBtn == "=" {
            resultLabel = worker.calculateTheResult(label: label)
        }else {
            resultLabel = worker.addingBtnToLabel(label: label, labelBtn: labelBtn)
        }
          
        guard let resultLabel else {return}
        
        presenter.presentResult(result: resultLabel)
        
    }
    
    func didChangedOrientation(to orientation: CalculatorOrientation) {
        presenter.changeCalculatorPosition(to: orientation)
    }
}
