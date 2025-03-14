//
//  HomePresenter.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//


protocol HomePresenterProtocol {
    
    func presentResult(result: String)
    
}

final class HomePresenter {
    
    weak var view: HomeViewProtocol?

}


extension HomePresenter: HomePresenterProtocol {
    
    func presentResult(result: String) {
        
        print("Saying the view to present Result")
        
        view?.displayResult(result: result)
    }
    
}



