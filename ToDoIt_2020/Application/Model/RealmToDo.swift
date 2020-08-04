//
//  RealmToDo.swift
//  ToDoIt_2020
//
//  Created by Владислав on 23.07.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.
//

import Foundation
import RealmSwift


class TasksNote: Object {
    
    @objc dynamic var task = ""
    @objc dynamic var completed = false
    
    var item: Results<TasksNote> {
        let realm = try! Realm()
        return realm.objects(TasksNote.self)
    }
    
    func addRealm(add:TasksNote){
        let realm = try! Realm()
        try! realm.write{
            realm.add(add)
        }
    }
    
    func deleteRealm(delete:TasksNote){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(delete)
        }
    }
    
    func updateCheck(task : TasksNote ) {
        let realm = try! Realm()
        try! realm.write {
            task.completed = !task.completed
        }
    }
    
    func updateTask(editTask : TasksNote, newTask: String ) {
        let realm = try! Realm()
        try! realm.write {
            editTask.task = newTask
        }
    }
    
    
}
