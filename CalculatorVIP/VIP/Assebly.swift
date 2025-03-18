//
//  Assebly.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//


//MARK: - Tasks
/*
 
 need to understand well infinix to postfix
 
 need to know why we have " " after the element in infinix_to_postfix function
 
 8.8 - 5
 
 after = need to change if number pressed
 
 need to fix orientation
 
 Enum from numbers

 Making smaller label when writing

 Creating Rpn service                  -> done

 Implementing minus

 Making another page of history

 Making above history

 Instead of if -> guard string?

 CoreData with history in tableView
 
 
 */


import Foundation

protocol HomeAssemblyProtocol {
    func creteCalcHomeViewController() -> HomeViewController
}


final class HomeAssembly: HomeAssemblyProtocol {
    
     func creteCalcHomeViewController() -> HomeViewController {
        
        let rpnService = RPNService()
         
        let inputSourceOfRPnService = InputSourceService()
    
        let presenter = HomePresenter()
        
        let router = HomeRouter()
        
        let worker = HomeWorker(rpnCalculatorService: rpnService, inputSourceOfRpnService: inputSourceOfRPnService)
        
        let interactor = HomeInteractor(presenter: presenter, worker: worker)
        
        let viewController = HomeViewController(
            interactor: interactor,
            router: router
        )
                
        presenter.view = viewController
        router.viewContreller = viewController
        
        return viewController
    }
}
