//
//  Assebly.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

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
