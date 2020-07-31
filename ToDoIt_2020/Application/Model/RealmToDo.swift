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
}

