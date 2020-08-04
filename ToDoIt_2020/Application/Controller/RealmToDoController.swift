//
//  RealmToDoController.swift
//  ToDoIt_2020
//
//  Created by Владислав on 21.07.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.
//
import Foundation
import UIKit


class RealmToDoController: UIViewController {
    
    var items = TasksNote().item
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Новая задача", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Добавить", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                let task = TasksNote()
                task.task = newTaskTitle
                TasksNote().addRealm(add: task)
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

extension RealmToDoController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count != 0 {
            return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoTableViewCell
        let item = items[indexPath.row]
        cell.taskLabel.text = item.task
       
        if item.completed == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let test = items[indexPath.row]
        TasksNote().updateCheck(task: test)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editingRow = items[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить"){ _,_  in
            TasksNote().deleteRealm(delete: editingRow)
            self.tableView.reloadData()
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Изменить"){ _,_  in
            let alertController = UIAlertController(title: "Изменить задачу", message: "", preferredStyle: .alert)
            let saveAction = UIAlertAction(title: "Изменить", style: .default) { action in
                let tf = alertController.textFields?.first
                if let newTaskTitle = tf?.text {
                    TasksNote().updateTask(editTask: editingRow, newTask: newTaskTitle)
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

