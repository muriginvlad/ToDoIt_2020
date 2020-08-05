//
//  CoreDataToDo.swift
//  ToDoIt_2020
//
//  Created by Владислав on 03.08.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.
//
import UIKit
import Foundation
import CoreData

class CoreDataToDo {
    
    var tasks: [TasksDate] = []
    
    
    func getContext() -> NSManagedObjectContext {
        let appDeligate = UIApplication.shared.delegate as! AppDelegate
        return  appDeligate.persistentContainer.viewContext
        
    } 
     
    
    func saveTask(withTitle title: String) {
        
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "TasksDate", in: context) else { return }
        let taskObject = TasksDate(entity: entity, insertInto: context)
        taskObject.task = title
        
        do {
            try context.save()
            tasks.append(taskObject)
        }
        catch let error as NSError { print(error.localizedDescription)
        }
    }
    
    func getTask() -> [TasksDate] {
        
        let context = getContext()
        let fetchRequest: NSFetchRequest<TasksDate> = TasksDate.fetchRequest()

        do {
            tasks = try context.fetch(fetchRequest)
        }
        catch let error as NSError {print(error.localizedDescription)}
        
        return tasks
    } 
    
    func deleteTask (taskIndex: Int) {
        let context = getContext()
        let fetchRequest: NSFetchRequest<TasksDate> = TasksDate.fetchRequest()
        
        if let tasks = try? context.fetch(fetchRequest) {
            
            context.delete(tasks[taskIndex])
        }

        do {
            try context.save()
        }
        catch let error as NSError { print(error.localizedDescription)
        }
    }
    
    func updateCheck(task : TasksDate ) {
        task.isComplited = !task.isComplited
        }
    
}

