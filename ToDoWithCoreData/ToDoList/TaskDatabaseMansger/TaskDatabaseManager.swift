//
//  DatabaseManager.swift
//  ToDoWithCoreData
//
//  Created by Михаил Красильник on 06.02.2021.
//

import UIKit
import CoreData


class TaskDatabaseManager {
    
    private init() {}
    
    static func saveTask(withTitle: String, body: String?, viewContext: NSManagedObjectContext, completion: @escaping (Task) -> ()) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: viewContext) else { return }
        
        let taskObject = Task(entity: entity, insertInto: viewContext)
        taskObject.title = withTitle
        if let body = body {
            taskObject.body = body
        }
        
        do {
            try viewContext.save()
            completion(taskObject)
        } catch let error as NSError {
            print(error)
        }
    }
    
    static func getTasks(viewContext: NSManagedObjectContext) -> [Task] {
        
        var tasks: [Task] = []
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            tasks = try viewContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return tasks
    }
    
    static func deleteTask(viewContext: NSManagedObjectContext, index: Int) -> Bool {
        
        var success = false
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        if let objects = try? viewContext.fetch(fetchRequest) {
            
            let object = objects[index]
            viewContext.delete(object)
        
            do {
                try viewContext.save()
                success = true
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        return success
    }  
}

