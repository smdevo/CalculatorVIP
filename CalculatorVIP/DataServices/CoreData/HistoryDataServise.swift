//
//  TableViewDataServise.swift
//  CalculatorVIP
//
//  Created by Samandar on 21/03/25.
//

import UIKit
import CoreData

protocol HistoryDataServiseProtocol {
        
    //read
    func fetchHistory() -> [Calculation]
    
    //create
    func saveCalculation(calculationStr: String)
    
    //delete
    func removeCalculation(indexPath: Int, items: [Calculation])
    
}



final class HistoryDataServise: HistoryDataServiseProtocol {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    
    func fetchHistory() -> [Calculation] {
        let request: NSFetchRequest<Calculation> = Calculation.fetchRequest()
            do {
                let calculations = try context.fetch(request)
                return calculations
            } catch {
                print("Failed to fetch tasks: \(error)")
            }
        return []
        }
    
    
    func saveCalculation(calculationStr: String) {
        let newCalculation = Calculation(context: context)
        newCalculation.date = Date()
        newCalculation.expression = calculationStr
        finalSave()
    }
    

    func removeCalculation(indexPath: Int, items: [Calculation]) {
        let dataToRemove = items[indexPath]
        context.delete(dataToRemove)
        finalSave()
    }
    
    
    
    private func finalSave() {
        do {
            try context.save()
        } catch {
            print("error-Saving data")
        }
    }
    
}
