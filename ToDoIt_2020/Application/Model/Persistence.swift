//
//  File.swift
//  ToDoIt_2020
//
//  Created by Владислав on 21.07.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.


import Foundation

class Persistence {
    
    static let shared = Persistence()
    
    private let kNameUser = "Persistence.kNameUser"

    
    var nameUser: String? {
        set { UserDefaults.standard.set(newValue, forKey: kNameUser) }
        get { return UserDefaults.standard.string(forKey: kNameUser) }
    }
    
    private let kSurnameUser = "Persistence.kSurnameUser"
    
    var surnameUser: String? {
        set { UserDefaults.standard.set(newValue, forKey: kSurnameUser) }
        get { return UserDefaults.standard.string(forKey: kSurnameUser) }
    }
    
}


