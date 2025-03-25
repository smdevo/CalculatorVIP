//
//  HomePresenter.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//


protocol HomePresenterProtocol {
    func presentResult(result: String)
    func presentNumberPadStackView()
    func presentHistory(calculations: [Calculation])
}

final class HomePresenter {
    let portaitStructure: [[CButton]] = [
        [.delete, .openBr, .closeBr, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .add],
        [.clear, .zero, .dot, .equal]
    ]
    
    weak var view: HomeViewProtocol?
}


extension HomePresenter: HomePresenterProtocol {
    
    func presentHistory(calculations: [Calculation]) {
        view?.displayHistory(calculations: calculations)
    }
    
    func presentResult(result: String) {
        view?.displayLabelResult(result: result)
    }
    
    func presentNumberPadStackView() {
        view?.displayNumberPadStackView(from: portaitStructure)
    }
}



