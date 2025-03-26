//
//  Assebly.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//


//MARK: - Tasks
/*
 
 need to write unit test
 
 need to change string to enum                     ->done
    
 need to fix time formatting                      -> done
 
 need to create custom cell with data             -> done
  
 8.8 - 5                                          -> done
 
 setting constraint extention                     -> done
 
 after = need to change if number pressed         -> done
  
 Enum from numbers                                -> done

 Creating Rpn service                             -> done

 Implementing minus                               -> done

 Making above history                             -> done

 CoreData with history in tableView               -> done
  
 */


import Foundation

protocol HomeAssemblyProtocol {
    func creteCalcHomeViewController() -> HomeViewController
}


final class HomeAssembly: HomeAssemblyProtocol {
    
     func creteCalcHomeViewController() -> HomeViewController {
        
        let rpnService = RPNService()
         
        let inputSourceOfRPnService = InputSourceService()
         
        let historyDataService = HistoryDataServise()
    
        let presenter = HomePresenter()
                
        let worker = HomeWorker(
            rpnCalculatorService: rpnService,
            inputSourceOfRpnService: inputSourceOfRPnService,
            historyDataService: historyDataService)
        
        let interactor = HomeInteractor(
            presenter: presenter,
            worker: worker)
        
         let viewController = HomeViewController(interactor: interactor)
                
        presenter.view = viewController
        return viewController
    }
}
