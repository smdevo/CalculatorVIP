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
}

final class HomePresenter {
    var portaitStructure: [[String]] = [
        ["⌫", "(", ")", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "－"],
        ["1", "2", "3", "+"],
        ["AC", "0", ".", "="]
    ]
    
    var lanscapeStructure: [[String]] = [
        ["7", "8", "9", "⌫", "÷"],
        ["4", "5", "6",  "(", "×"],
        ["1", "2", "3", ")", "－"],
        ["AC", "0", ".", "=", "+"]
    ]
    
    weak var view: HomeViewProtocol?
}


extension HomePresenter: HomePresenterProtocol {
        
    func presentResult(result: String) {
        
       // print("Saying the view to present Result")
        
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



