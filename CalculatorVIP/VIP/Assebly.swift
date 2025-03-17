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
