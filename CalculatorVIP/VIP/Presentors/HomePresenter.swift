//
//  HomePresenter.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//


protocol HomePresenterProtocol {
    func presentResult(result: String, expression: String?)
    func setNumberPadStackView()
    func changeCalculatorPosition(to orientation: CalculatorOrientation)
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
        
    func presentResult(result: String, expression: String?) {
        
       // print("Saying the view to present Result")
        
        view?.displayResult(result: result, expression: expression)
    }
    
    func setNumberPadStackView() {
        view?.setNumberPadStackView(from: portaitStructure, isRemoveAllEmentsFromStack: false)
    }
    
    func changeCalculatorPosition(to orientation: CalculatorOrientation) {
        let structure = orientation == .landscale ? lanscapeStructure : portaitStructure
        
        view?.setNumberPadStackView(from: structure, isRemoveAllEmentsFromStack: true)
    }
}



