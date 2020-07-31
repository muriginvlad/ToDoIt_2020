//
//  CoreDataToDoController.swift
//  ToDoIt_2020
//
//  Created by Владислав on 23.07.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.


import UIKit
import CoreData


class CoreDataToDoController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tasks: [TasksDate] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDeligate = UIApplication.shared.delegate as! AppDelegate
        let context = appDeligate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TasksDate> = TasksDate.fetchRequest()
        
        do {tasks = try context.fetch(fetchRequest)}
        catch let error as NSError {print(error.localizedDescription)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Новая задача", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Добавить", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                self.saveTask(withTitle: newTaskTitle)
                self.tableView.reloadData()
            }
        }
        
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Отменить", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func saveTask(withTitle title: String) {
        let appDeligate = UIApplication.shared.delegate as! AppDelegate
        let context = appDeligate.persistentContainer.viewContext
        
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
}

extension CoreDataToDoController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoTableViewCell
        let task = tasks[indexPath.row]
        cell.taskLabel.text = task.task
        cell.accessoryType = .none
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        tasks.remove(at: indexPath.row)
    //        self.tableView.reloadData()
    //    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editingRow = tasks[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить"){ _,_  in
            
            let appDeligate = UIApplication.shared.delegate as! AppDelegate
            let context = appDeligate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<TasksDate> = TasksDate.fetchRequest()
            
            if let tasks = try? context.fetch(fetchRequest) {
                context.delete(tasks[indexPath.row])
            }

            do {
                try context.save()
            }
            catch let error as NSError { print(error.localizedDescription)
            }
            self.tableView.reloadData()
            
        }
        return [deleteAction]
    }
    
    
}

