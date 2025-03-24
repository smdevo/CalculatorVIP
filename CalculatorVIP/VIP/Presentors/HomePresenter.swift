//
//  HomePresenter.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//


protocol HomePresenterProtocol {
    func presentResult(result: String)
    func setNumberPadStackView()
    func changeCalculatorPosition(to orientation: CalculatorOrientation)
    func presentHistory(calculations: [Calculation])
}

final class HomePresenter {
    var portaitStructure: [[CButton]] = [
        [.delete, .openBr, .closeBr, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .add],
        [.clear, .zero, .dot, .equal]
    ]
    
    var lanscapeStructure: [[CButton]] = [
        [.seven, .eight, .nine, .delete, .divide],
        [.four, .five, .six,  .openBr, .multiply],
        [.one, .two, .three, .closeBr, .minus],
        [.clear, .zero, .dot, .equal, .add]
    ]
    
    weak var view: HomeViewProtocol?
}


extension HomePresenter: HomePresenterProtocol {
    
    
    func presentHistory(calculations: [Calculation]) {
        view?.displayHistory(calculations: calculations)
    }
    
        
    func presentResult(result: String) {
        view?.displayResult(result: result)
    }
    
    func setNumberPadStackView() {
        view?.setNumberPadStackView(from: portaitStructure, isRemoveAllEmentsFromStack: false)
    }
    
    func changeCalculatorPosition(to orientation: CalculatorOrientation) {
        let structure = orientation == .landscale ? lanscapeStructure : portaitStructure
        
        view?.setNumberPadStackView(from: structure, isRemoveAllEmentsFromStack: true)
    }
}



