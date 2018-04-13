//
//  ClassDetailViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/30/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit
import CoreData

class ClassDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listOfHomework: UITableView!
    
    var classHomewroks = [Homework]();
    var navTitle = ""
    var subject: Subject? = nil
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfHomework.delegate = self
        listOfHomework.dataSource = self
        
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        navigationItem.title = navTitle
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHomework))
        self.navigationItem.rightBarButtonItem = rightBarButton
        getHomeworks()
        self.listOfHomework.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addHomework(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "addHomewrokFromClasses", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return self.classHomewroks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("HomeworkTableViewCell", owner: self, options: nil)?.first as! HomeworkTableViewCell
        
        cell.backView.backgroundColor = self.subject?.color
        let row = indexPath.row
    
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
        
        return cell
        
    }
    
    
    func getHomeworks(){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "HomeworkEntity")
        let homeworksPredicate = NSPredicate(format: "subject == %@", (subject?.id)!)
        
        fetchRequest.predicate = homeworksPredicate
        
        var savedHomeworks: [NSManagedObject]!
        do {
            savedHomeworks = try self.managedObjectContext.fetch(fetchRequest) }
        catch {
                print("getHomeowkrs error: \(error)")
        }
        print("Found \(savedHomeworks.count) homeworks")
        
        classHomewroks = []
        for homework in savedHomeworks {
            let homeworkTitle = homework.value(forKey: "title") as! String
            let homeeworkDesc = homework.value(forKey: "desc") as! String
            let homeworkDueDate = homework.value(forKey: "dueDate") as! Date
            let newHomework = Homework(pTitle: homeworkTitle, pDescription: homeeworkDesc, pDueDate: homeworkDueDate)
            newHomework.id = homework.objectID as NSManagedObjectID
            classHomewroks.append(newHomework)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addHomewrokFromClasses"){
            let addHomeworkVC = segue.destination as! AddNewHomeworkViewController
            addHomeworkVC.navTitle = "Add Homework for \(self.navTitle)"
            addHomeworkVC.subject = self.subject
        }
    }
    
    
//    Add homework entity to core data
    func addHomeworkToCoreData(homeworkTitle: String, homeworkDesc: String, homeworkDueDate: Date, color: UIColor) -> NSManagedObjectID{
        let homeworkEntity = NSEntityDescription.insertNewObject(forEntityName:
            "HomeworkEntity", into: self.managedObjectContext)
        
        homeworkEntity.setValue(homeworkTitle, forKey: "title")
        homeworkEntity.setValue(homeworkDesc, forKey: "desc")
        homeworkEntity.setValue(homeworkDueDate, forKey: "dueDate")

        let fetchedSubject: NSManagedObject! = self.managedObjectContext.object(with: (self.subject?.id)!)
        homeworkEntity.setValue(fetchedSubject, forKey: "subject")
        
        self.appDelegate.saveContext()
        
        return homeworkEntity.objectID
    }
    
    
    @IBAction func unwindFromAddHomework (sender: UIStoryboardSegue) {
        let addHomeworkVC = sender.source as! AddNewHomeworkViewController
        let homeworkTitle = addHomeworkVC.homework.title
        let homeworkDesc = addHomeworkVC.homework.description
        let homewrokDueDate = addHomeworkVC.homework.dueDate
        
        let homeworkObjectID = addHomeworkToCoreData(homeworkTitle: homeworkTitle, homeworkDesc: homeworkDesc, homeworkDueDate: homewrokDueDate as Date, color: (self.subject?.color)!)
        
        let homework = Homework(pTitle: homeworkTitle, pDescription: homeworkDesc, pDueDate: homewrokDueDate)
        homework.id = homeworkObjectID
        
        classHomewroks.append(homework)
        self.listOfHomework.reloadData()
        
    }

}
