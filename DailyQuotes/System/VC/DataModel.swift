//
//  DataModel.swift
//  DailyQuotes
//
//  Created by Karan Bodar on 24/04/25.
//

import Foundation
import CoreData
import UIKit

class DataModel {
    static var shared = DataModel()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DailyQuotes")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data error: \(error)")
            }
        }
        return container
    }()
    
    func setUserData(content: String, auther: String){
        let context = persistentContainer.viewContext
        let entity = Quotes(context: context)
        entity.content = content
        entity.auther = auther
        
        do {
            try context.save()
        } catch {
            print("Failed to save data: \(error)")
        }
    }
    
    func getUserData() -> [Quotes] {
        let fetchRequest: NSFetchRequest<Quotes> = Quotes.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }
    func deleteUserData(content: String, auther: String) {
            let context = persistentContainer.viewContext
            do {
                let data = try context.fetch(Quotes.fetchRequest()) as? [Quotes]
                for i in data ?? [] {
                    if i.content == content, i.auther == auther {
                        context.delete(i)
                    }
                }
                print("🗑️ Data Deleted 🗑️")
                try context.save()
            } catch {}
        }
}
