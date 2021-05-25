//
//  DataManager.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 26/05/21.
//

import Foundation
import UIKit
import CoreData

class DatabaseManager {
    static let shared = DatabaseManager()
    
    // MARK: - init
    private init() {}
    
    /// saveDataInCoreData is used to save data from api to coredata
    ///
    /// - Parameter city: a CityElement type
    func saveDataInCoreData(with city: CityElement) {
        
        let _ = self.createCityObject(for: city)
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    /// createCityObject to return as managedObject
    ///
    /// - Parameters:
    ///   - city: holds object type of CityElement
    /// - Returns: NSManagedObject instance object
    private func createCityObject(for city: CityElement) -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext        
        if let cityObject = NSEntityDescription.insertNewObject(forEntityName: Constants.coreDataEntitiy, into: context) as? CityBookMarked {
            cityObject.name = city.name
            cityObject.lat = city.lat
            cityObject.lon = city.lon
            return cityObject
        }
        return nil
    }
    
    /// fetch data from CoreData
    ///
    /// - Returns: CityBookMarked object
    func fetchDataFromCoreData() -> [CityBookMarked] {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.coreDataEntitiy)
        do {
            let results = try context.fetch(fetchRequest)
            let  dataReceived = results as! [CityBookMarked]
            
            return dataReceived
        } catch let err as NSError {
            print(err.debugDescription)
            return []
        }
    }
    
    /// check if object is exist
    /// - Parameters:
    ///   - type: String tyoe object
    /// - Returns: Bool  a boolean variable
    func checkIfCityExist(type: String) -> Bool {
        let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.coreDataEntitiy)
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "name == %@", type)
        do {
            let count = try managedContext.count(for: fetchRequest)
            if count > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    /// delete single object from coredata
    /// - Parameters:
    ///   - type: String tyoe object
    /// - Returns: Bool  a boolean variable
    func deleteDataFromCoreData(cityObject: CityBookMarked) {
        let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        managedContext.delete(cityObject)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error While Deleting Note: \(error.userInfo)")
        }
    }
    
    /// ClearData on CoreData
    func clearData() {
        do {
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.coreDataEntitiy)
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
}
