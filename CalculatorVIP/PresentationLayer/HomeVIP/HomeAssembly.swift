//
//  Assebly.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//


//MARK: - Tasks
/*
 
 
 need to write unit test
 
 need to change string to enum
 
 need to learn delegate
 
 need to learn singleton better
 
 need to learn protocol better
 
 need to fix time formatting                      -> done
 
 need to create custom cell with data             -> done
 
 need to create accout to access from all devices
 
 Writing Tests
 
 adding expression label and change after equal sign and signing expression into tableView
 
 need to understand well infinix to postfix
 
 need to know why we have " " after the element in infinix_to_postfix function -> done
 
 8.8 - 5                               -> done
 
 setting constraint extention          -> done
 
 after = need to change if number pressed
 
 need to fix orientation               -> done
 
 Enum from numbers                     -> done

 Making smaller label when writing

 Creating Rpn service                  -> done

 Implementing minus                    -> done

 Making another page of history

 Making above history                  -> done

 Instead of if -> guard string?        -> done

 CoreData with history in tableView    -> done
 
 V ekrane toje rpn vidno c skobkoy and postfix form
 
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
        
        let router = HomeRouter()
        
         let worker = HomeWorker(
            rpnCalculatorService: rpnService,
            inputSourceOfRpnService: inputSourceOfRPnService,
            historyDataService: historyDataService)
        
        let interactor = HomeInteractor(
            presenter: presenter,
            worker: worker)
        
        let viewController = HomeViewController(
            interactor: interactor,
            router: router
        )
                
        presenter.view = viewController
        router.viewContreller = viewController
        
        return viewController
    }
}
