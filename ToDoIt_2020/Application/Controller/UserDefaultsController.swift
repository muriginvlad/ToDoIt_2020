//
//  ViewController.swift
//  ToDoIt_2020
//
//  Created by Владислав on 21.07.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.

import UIKit

class ViewController: UIViewController {

    @IBOutlet var helloLabel: UILabel!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var surnameText: UITextField!
    @IBOutlet var saveBytton: UIButton!
        
var name = ""
var sername = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloLabel.text = "Почему так долго пропадаешь?"
        saveBytton.layer.cornerRadius = 5
        
        nameText.text = Persistence.shared.nameUser
        surnameText.text = Persistence.shared.surnameUser

    }
    
    @IBAction func saveText(_ sender: Any) {
        
        Persistence.shared.nameUser = nameText.text
        Persistence.shared.surnameUser = surnameText.text
        
        
    }
    


}

