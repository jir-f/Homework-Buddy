//
//  TodayViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 4/15/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class TodayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate  {

    var classHomewroks = [Homework]();
    var allHomeworks = [Homework]();
    
    @IBOutlet weak var todayTable: UITableView!
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayTable.delegate = self
        todayTable.dataSource = self
        
        UNUserNotificationCenter.current().delegate = self
        navigationItem.title = Helper.convertToString(date: Date())
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        getHomeworks()
        self.todayTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        classHomewroks = []
        getHomeworks()
        self.todayTable.reloadData()
    }

    
    func getHomeworks(){
        let fetchClassesRequest = NSFetchRequest<NSManagedObject>(entityName: "SubjectEntity")
        
        var savedClasses: [NSManagedObject]!
        do {
            savedClasses = try self.managedObjectContext.fetch(fetchClassesRequest) }
        catch {
            print("getHomeowkrs classes error: \(error)")
        }
        print("Found \(savedClasses.count) classes")
        
        for subject in savedClasses {
            let fetchHomeworkRequest = NSFetchRequest<NSManagedObject>(entityName: "HomeworkEntity")
            let homeworksPredicate = NSPredicate(format: "subject == %@", (subject.objectID))
            fetchHomeworkRequest.predicate = homeworksPredicate
            
            var savedHomeworks: [NSManagedObject]!
            do {
                savedHomeworks = try self.managedObjectContext.fetch(fetchHomeworkRequest) }
            catch {
                print("getHomeowkrs classes error: \(error)")
            }
            
            for homework in savedHomeworks {
                let homeworkTitle = homework.value(forKey: "title") as! String
                let homeeworkDesc = homework.value(forKey: "desc") as! String
                let homeworkDueDate = homework.value(forKey: "dueDate") as! Date
                let newHomework = Homework(pTitle: homeworkTitle, pDescription: homeeworkDesc, pDueDate: homeworkDueDate)
                newHomework.color = subject.value(forKey: "color") as! UIColor
                newHomework.id = homework.objectID as NSManagedObjectID
                newHomework.subject = subject.value(forKey: "name") as! String
                
                let due = Helper.convertToString(date: homeworkDueDate)
                let today = Helper.convertToString(date: Date())
                if(due == today){
                    classHomewroks.append(newHomework)
                }
                    allHomeworks.append(newHomework)
            }
        }
        
        if (!self.classHomewroks.isEmpty){
            self.classHomewroks = Helper.sortHomework(homeworkList: self.classHomewroks)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classHomewroks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = Bundle.main.loadNibNamed("HomeworkTableViewCell", owner: self, options: nil)?.first as! HomeworkTableViewCell
        
        let row = indexPath.row
        
        cell.backView.backgroundColor = classHomewroks[row].color
        
        
        cell.homeworkTitle.text = classHomewroks[row].title
        
        cell.homeworkDesc.text = classHomewroks[row].description
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM";
        
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        
        
        let month = Helper.monthFormatter(date: classHomewroks[row].dueDate)
        
        //         let month = dateFormatter.string(from: classHomewroks[row].dueDate as Date)
        cell.monthLabel.text = String(month.prefix(5))
        
        
        let day = Helper.dayFormatter(date: classHomewroks[row].dueDate)
        //        let day = dayFormatter.string(from: classHomewroks[row].dueDate as Date)
        cell.dayLabel.text = day
        
        
        cell.backView.bounds.size = CGSize(width: 75, height: 75)
        
        cell.backView.clipsToBounds = true
        cell.backView.layer.cornerRadius = 20
        
        
        let timeDue = Helper.getTime(date: classHomewroks[row].dueDate)
        cell.homeworkTime.text = timeDue
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "todayHomeworkDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "todayHomeworkDetail"){
            let homewrokDetailVC = segue.destination as! HomeworkDetailViewController
            homewrokDetailVC.navTitle = self.classHomewroks[selectedRow].subject
            homewrokDetailVC.passedTitle = self.classHomewroks[selectedRow].title
            homewrokDetailVC.passedDescription = self.classHomewroks[selectedRow].description
            homewrokDetailVC.passedDueDate = Helper.dateToDateHours(date: self.classHomewroks[selectedRow].dueDate)
            homewrokDetailVC.color = self.classHomewroks[selectedRow].color
            
        }
        else if (segue.identifier == "notificationDetail"){
            let homewrokDetailVC = segue.destination as! HomeworkDetailViewController
            homewrokDetailVC.navTitle = self.allHomeworks[selectedRow].subject
            homewrokDetailVC.passedTitle = self.allHomeworks[selectedRow].title
            homewrokDetailVC.passedDescription = self.allHomeworks[selectedRow].description
            homewrokDetailVC.passedDueDate = Helper.dateToDateHours(date: self.allHomeworks[selectedRow].dueDate)
            homewrokDetailVC.color = self.allHomeworks[selectedRow].color
            
        }
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
//        if ((navigationController?.topViewController)?.isKind(of: UIViewController.self))!{
//
//
//        }
//        else{
//            
//        }
        //navigationController?.popToRootViewController(animated: true)
        let respDest = response.notification.request.content.categoryIdentifier
        print(respDest)
        
        let tmpString = respDest.components(separatedBy: ";")
        
        
        let homeworkTitle = tmpString[0]
        let homeworkDescription = tmpString[1]
        
        if ( allHomeworks.contains(where: {$0.title == homeworkTitle && $0.description == homeworkDescription})){
            selectedRow = allHomeworks.index{$0.title == homeworkTitle && $0.description == homeworkDescription}!
            performSegue(withIdentifier: "notificationDetail", sender: nil)
        }
    }
    
    func removeHomework(deleteHomework: Homework){
        
        let homeworkObject: NSManagedObject! = self.managedObjectContext.object(with: deleteHomework.id)
        
        self.managedObjectContext.delete(homeworkObject)
        
        self.appDelegate.saveContext()
        
    }
    
    @IBAction func unwindFromCompleteHwToToday (sender: UIStoryboardSegue) {
        let detailHomeworkVC = sender.source as! HomeworkDetailViewController
        let homeworkName = detailHomeworkVC.passedTitle
        
        if (classHomewroks.contains(where: {$0.title == homeworkName})){
            let deletedRow = classHomewroks.index{$0.title == homeworkName}!
            self.removeHomework(deleteHomework: classHomewroks[deletedRow])
            self.classHomewroks.remove(at: deletedRow)
            self.todayTable.reloadData()
            
        }
    }

}
