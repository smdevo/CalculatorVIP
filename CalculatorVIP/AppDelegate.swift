//
//  AppDelegate.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let assembly = HomeAssembly()
        window?.rootViewController = Trash2()
//        window?.rootViewController = assembly.creteCalcHomeViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

