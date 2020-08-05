//
//  CoreDataToDoController.swift
//  ToDoIt_2020
//
//  Created by Владислав on 23.07.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.
import UIKit

class CoreDataToDoController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var tasks = CoreDataToDo().tasks
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasks = CoreDataToDo().getTask()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Новая задача", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Добавить", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                CoreDataToDo().saveTask(withTitle: newTaskTitle)
                self.tasks = CoreDataToDo().getTask()
                self.tableView.reloadData()
            }
        }
        
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Отменить", style: .default) { _ in }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
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
        if task.isComplited == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let test = tasks[indexPath.row]
        CoreDataToDo().updateCheck(task: test)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editingRow = tasks[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить"){ _,_  in
            CoreDataToDo().deleteTask(taskIndex:indexPath.row)
            self.tasks = CoreDataToDo().getTask()
            self.tableView.reloadData()
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Изменить"){ _,_  in
            let alertController = UIAlertController(title: "Изменить задачу", message: "", preferredStyle: .alert)
            let saveAction = UIAlertAction(title: "Изменить", style: .default) { action in
                let tf = alertController.textFields?.first
                if let newTaskTitle = tf?.text {
                    self.tasks[indexPath.row].task = newTaskTitle
                    self.tableView.reloadData()
                }
            }
            alertController.addTextField { _ in }
            let cancelAction = UIAlertAction(title: "Отменить", style: .default) { _ in }
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            self.tableView.reloadData()
        }
        editAction.backgroundColor = .blue
        
        let action = [deleteAction,editAction]
        return action
    }
}

