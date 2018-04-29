//
//  AddNewHomeworkViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 4/8/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class AddNewHomeworkViewController: UIViewController {

    @IBOutlet weak var homeworkTitle: UITextField!
    
    @IBOutlet weak var homewrokDescription: UITextField!
    
    @IBOutlet weak var dueDate: UITextField!
    
    @IBOutlet weak var alertTime: UITextField!
    
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    
    var subject: Subject? = nil
    var navTitle = ""
    var homework = Homework(pTitle: "", pDescription: "", pDueDate: Date())
    
    let datePicker = UIDatePicker()
    
    var notifyDate: Date = Date()
    
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
            dueDate.placeholder = "Missing homework due date"
            dueDate.backgroundColor = .red
        }
        else if (alertTime.text?.isEmpty)!{
            alertTime.placeholder = "Missing homework Alert time"
            alertTime.backgroundColor = .red
        }
        else{
            let date = datePicker.date
            self.homework.title = homeworkTitle.text!
            self.homework.description = homewrokDescription.text!
            self.homework.dueDate = date
            
            let alert = UIAlertController(title: "Add Homework \(self.homework.title) ", message: "Alert at \(self.alertTime.text ?? "No alert for this homework")", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
                //run your function here
                self.scheduleNotification()
                self.performSegue(withIdentifier: "unwindFromAddHomework", sender: nil)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
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
        let toolbarDueDate = UIToolbar()
        toolbarDueDate.sizeToFit()
        
        let toolbarAlert = UIToolbar()
        toolbarAlert.sizeToFit()
        
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbarDueDate.setItems([doneBarButton], animated: false)
        
        
        let doneBarButtonAlert = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedAlert))
        toolbarAlert.setItems([doneBarButtonAlert], animated: false)
        
        
        dueDate.inputAccessoryView = toolbarDueDate
        dueDate.inputView = datePicker
        
        alertTime.inputAccessoryView = toolbarAlert
        alertTime.inputView = datePicker
        
    }
    
    @objc func donePressed(){
        dueDate.text = "\(Helper.dateToDateHours(date: datePicker.date))"
        self.view.endEditing(true)
    }
   
    @objc func donePressedAlert(){
        alertTime.text = "\(Helper.dateToDateHours(date: datePicker.date))"
        notifyDate = datePicker.date
        self.view.endEditing(true)
    }

    
//    Schedule notification
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "\(self.homeworkTitle.text ?? "Homework Buddy")"
        content.body = "\(self.homewrokDescription.text ?? "You have a homework coming up")"
        content.userInfo["homework_notifications"] = self.homeworkTitle.text
        content.badge = 1
        content.categoryIdentifier = "\(self.homeworkTitle.text!);\(self.homewrokDescription.text!)"
        
        
        
        var alertComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.notifyDate)
        alertComponent.second = 0
        
        // Configure trigger for alert time 
        let trigger = UNCalendarNotificationTrigger(dateMatching: alertComponent, repeats: false)
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0,repeats: false)
        
        let request = UNNotificationRequest(identifier: "HOMEWORK_SCHEDULED",
                                            content: content, trigger: trigger)
        // Schedule request
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print("The error in schedule request is: ",theError.localizedDescription)
            } }
    }

}
