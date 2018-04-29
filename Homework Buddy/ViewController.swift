//
//  ViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/20/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

class ViewController: UITabBarController, UNUserNotificationCenterDelegate {
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
        UIApplication.shared.applicationIconBadgeNumber = 0
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        initClasses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initClasses(){
        
        var subjectName = "Biology"
        var subjectColor = getRandomColor()
        
        let bioId = addClassToCoreData(className: subjectName, color: subjectColor)
        for i in 1...3 {
            addHomeworkToCoreData(homeworkTitle: "Homework \(i)", homeworkDesc: "Description \(i)", homeworkDueDate: Date(), color: subjectColor, subjectId: bioId)
        }
        
        subjectName = "Math"
        subjectColor = getRandomColor()
        
        addHomeworkToCoreData(homeworkTitle: "Homework 1", homeworkDesc: "Description for the math homework", homeworkDueDate: Date(), color: subjectColor, subjectId: addClassToCoreData(className: subjectName, color: subjectColor))
        
        
        subjectName = "Physics"
        subjectColor = getRandomColor()
        
        addHomeworkToCoreData(homeworkTitle: "Homework 1", homeworkDesc: "Description for the physics homework", homeworkDueDate: Date(), color: subjectColor, subjectId: addClassToCoreData(className: subjectName, color: subjectColor))
        
        
    }
    
    func addClassToCoreData(className: String, color: UIColor) -> NSManagedObjectID{
        let subject = NSEntityDescription.insertNewObject(forEntityName:
            "SubjectEntity", into: self.managedObjectContext)
        subject.setValue(className, forKey: "name")
        subject.setValue(color, forKey: "color")
        self.appDelegate.saveContext()
        return subject.objectID
    }
    
    func addHomeworkToCoreData(homeworkTitle: String, homeworkDesc: String, homeworkDueDate: Date, color: UIColor, subjectId: NSManagedObjectID){
        
        let homeworkEntity = NSEntityDescription.entity(forEntityName: "HomeworkEntity", in: self.managedObjectContext)
        let homework = HomeworkEntity(entity: homeworkEntity!, insertInto: self.managedObjectContext)
        homework.title = homeworkTitle
        homework.desc = homeworkDesc
        homework.dueDate = homeworkDueDate
        
        do {
            let fetchedSubject = try self.managedObjectContext.existingObject(with: (subjectId))
            homework.subject = fetchedSubject as? SubjectEntity
            
        } catch  {
            print(error)
        }
        
        self.appDelegate.saveContext()
    }
    
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
}

