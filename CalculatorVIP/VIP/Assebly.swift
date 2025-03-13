//
//  Assebly.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

import Foundation

final class HomeAssambly {
    
    static func assembly() -> HomeViewController {
        
    
        let presenter = HomePresenter()
        
        let router = HomeRouter()
        
        let worker = HomeWorker()
        
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
