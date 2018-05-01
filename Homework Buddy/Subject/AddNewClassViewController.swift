//
//  AddNewClassViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 4/8/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit
import CoreData

class AddNewClassViewController: UIViewController, UITextFieldDelegate {
    
    var subjectName: String = ""
    
    @IBOutlet weak var classTextField: UITextField!
    
    @IBAction func addNewClassButton(_ sender: Any) {
        if (classTextField.text?.isEmpty)! {
            classTextField.placeholder = "Missing class name"
            classTextField.backgroundColor = .red
        }
        else{
            subjectName = classTextField.text!
            performSegue(withIdentifier: "unwindFromAddClass", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Class"
        self.classTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        classTextField.resignFirstResponder()
        return true
    }
    
}
