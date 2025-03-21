//
//  TableViewDataServise.swift
//  CalculatorVIP
//
//  Created by Samandar on 21/03/25.
//

import UIKit
import CoreData

protocol HistoryDataServiseProtocol {
    
   // var history: [Calculation] {get}
    
    //read
    func fetchHistory() -> [Calculation]
    
    //create
    func saveCalculation(calculationStr: String)
    
    //delete
    func removeCalculation(indexPath: Int, items: [Calculation]) -> [Calculation]
    
//    //reload
//    func reloadHistory()
}



final class HistoryDataServise: HistoryDataServiseProtocol {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   // var history: [Calculation] = []
    
    
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
    

    func removeCalculation(indexPath: Int, items: [Calculation]) -> [Calculation] {
        
        let dataToRemove = items[indexPath]
        context.delete(dataToRemove)
        finalSave()
        return fetchHistory()
    }
    
//    func reloadHistory() {
//        <#code#>
//    }
    
    
    private func finalSave() {
        do {
            try context.save()
        } catch {
            print("error-Saving data")
        }
    }
    
}




//// MARK: - Core Data Entity
//extension Calculation {
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Calculation> {
//        return NSFetchRequest<Calculation>(entityName: "Calculation")
//    }
//    @NSManaged public var title: String?
//}





//    func fetchHistory() {
//        <#code#>
//    }

//    func fetchHistory(onSuccess: @escaping ([Calculation]?) -> Void) {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        do {
//            let items = try context.fetch(Calculation.fetchRequest()) as? [Calculation]
//            onSuccess(items)
//        } catch {
//            print("error-Fetching data")
//        }
//    }
