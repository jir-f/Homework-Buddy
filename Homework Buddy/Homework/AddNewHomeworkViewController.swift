//
//  AddNewHomeworkViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 4/8/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit
import CoreData

class AddNewHomeworkViewController: UIViewController {

    @IBOutlet weak var homeworkTitle: UITextField!
    
    @IBOutlet weak var homewrokDescription: UITextField!
    
    @IBOutlet weak var dueDate: UITextField!
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    
    var subject: Subject? = nil
    var navTitle = ""
    var homework = Homework(pTitle: "", pDescription: "", pDueDate: Date())
    
    let datePicker = UIDatePicker()
    
    @IBAction func addHomeworkButton(_ sender: Any) {
        
        if (homeworkTitle.text?.isEmpty)!{
            homeworkTitle.placeholder = "Missing homework title"
            homeworkTitle.backgroundColor = .red
        }
        else if (homewrokDescription.text?.isEmpty)!{
            homewrokDescription.placeholder = "Missing homework Descirption"
            homewrokDescription.backgroundColor = .red
        }
        else if (dueDate.text?.isEmpty)!{
            homewrokDescription.placeholder = "Missing homework due date"
            homewrokDescription.backgroundColor = .red
        }
        else{
            let date = datePicker.date
            self.homework.title = homeworkTitle.text!
            self.homework.description = homewrokDescription.text!
            self.homework.dueDate = date
             performSegue(withIdentifier: "unwindFromAddHomework", sender: nil)
//            addHomeworkToCoreData(homeworkTitle: homeworkTitle.text!, homeworkDesc: homewrokDescription.text!, homeworkDueDate: date!, color: (self.subject?.color)!)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navTitle
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        createDatePicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBarButton], animated: false)
        
        dueDate.inputAccessoryView = toolbar
        dueDate.inputView = datePicker
    }
    
    @objc func donePressed(){
        dueDate.text = "\(datePicker.date)"
        self.view.endEditing(true)
    }
   
    func addHomeworkToCoreData(homeworkTitle: String, homeworkDesc: String, homeworkDueDate: Date, color: UIColor) -> NSManagedObjectID{
        
//        let subject = NSEntityDescription.insertNewObject(forEntityName:
//            "HomeworkEntity", into: self.managedObjectContext)
        
        let homeworkEntity = NSEntityDescription.entity(forEntityName: "HomeworkEntity", in: self.managedObjectContext)
        let homework = HomeworkEntity(entity: homeworkEntity!, insertInto: self.managedObjectContext)
        homework.title = homeworkTitle
        homework.desc = homeworkDesc
        homework.dueDate = homeworkDueDate
        
        do {
            let fetchedSubject = try self.managedObjectContext.existingObject(with: (self.subject?.id)!)
            homework.subject = fetchedSubject as? SubjectEntity
            
        } catch  {
            print(error)
        }
        
        self.appDelegate.saveContext()
        
        return homework.objectID
    }

}
