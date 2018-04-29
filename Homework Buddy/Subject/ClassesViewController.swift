 //
//  ClassesViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/22/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit
import CoreData
 
class ClassesViewController: UICollectionViewController {
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    var listOfClasses = [Subject]()
    var selectedRow = 0
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        collectionView?.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        getClasses()
        
        //initClasses()
        
    }
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // 1
//        return 1
//    }
//
    
    func getClasses(){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SubjectEntity")
        var savedClasses: [NSManagedObject]!
        do {
            savedClasses = try self.managedObjectContext.fetch(fetchRequest) } catch {
                print("getClasses error: \(error)")
        }
        print("Found \(savedClasses.count) classes")
        
        listOfClasses = []
        for subject in savedClasses {
            let subjectName = subject.value(forKey: "name") as! String
            
            let subjectColor = subject.value(forKey: "color") as! UIColor
            let newSubject = Subject(pTitle: subjectName, pColor: subjectColor)
            newSubject.id = subject.objectID as NSManagedObjectID
            listOfClasses.append(newSubject)
        }
    }
    
    func initClasses(){

        var subjectName = "Biology"
        var subjectColor = getRandomColor()
        listOfClasses.append(Subject(pTitle: subjectName, pColor: subjectColor))
        listOfClasses.last?.id = addClassToCoreData(className: subjectName, color: subjectColor)
        
        
        for i in 1...5 {
            addHomeworkToCoreData(homeworkTitle: "Homework \(i)", homeworkDesc: "Description \(i)", homeworkDueDate: Date(), color: (listOfClasses.last?.color)!, subjectId: (listOfClasses.last?.id)!)
        }
        
        subjectName = "Math"
        subjectColor = getRandomColor()
        listOfClasses.append(Subject(pTitle: subjectName, pColor: subjectColor))
        listOfClasses.last?.id = addClassToCoreData(className: subjectName, color: subjectColor)
        
        addHomeworkToCoreData(homeworkTitle: "Homework 1", homeworkDesc: "Description for the math homework", homeworkDueDate: Date(), color: (listOfClasses.last?.color)!, subjectId: (listOfClasses.last?.id)!)
        
        
        subjectName = "Physics"
        subjectColor = getRandomColor()
        listOfClasses.append(Subject(pTitle: subjectName, pColor: subjectColor))
        listOfClasses.last?.id = addClassToCoreData(className: subjectName, color: subjectColor)
        
        addHomeworkToCoreData(homeworkTitle: "Homework 1", homeworkDesc: "Description for the physics homework", homeworkDueDate: Date(), color: (listOfClasses.last?.color)!, subjectId: (listOfClasses.last?.id)!)
        
        
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfClasses.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "classCell", for: indexPath) as! ClassesCollectionViewCell
        
        cell.backgroundColor = listOfClasses[indexPath.row].color
        
        cell.layer.cornerRadius = 10.0
        
        cell.subject = listOfClasses[indexPath.row].title
        
        cell.delegate = self
        
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "classDetail", sender: nil)
    }
    
    
    // Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.addBarButtonItem.isEnabled = !editing
        
        if let indexPaths = collectionView?.indexPathsForVisibleItems{
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? ClassesCollectionViewCell{
                    cell.isEditing = editing
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "classDetail"){
            let classDetailVC = segue.destination as! ClassDetailViewController
            classDetailVC.navTitle = self.listOfClasses[selectedRow].getTitle()
            classDetailVC.classHomewroks = self.listOfClasses[selectedRow].getHomeworks()
            classDetailVC.subject = self.listOfClasses[selectedRow]
        }
    }
    
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
    func addClassToCoreData(className: String, color: UIColor) -> NSManagedObjectID{
        let subject = NSEntityDescription.insertNewObject(forEntityName:
            "SubjectEntity", into: self.managedObjectContext)
        subject.setValue(className, forKey: "name")
        subject.setValue(color, forKey: "color")
        self.appDelegate.saveContext()
        return subject.objectID
    }
    
    // Delete subjects from core data
    func deleteFromCoreData(rowNumber: Int){
        let selectedSubject = listOfClasses[rowNumber]
        
        // 1. delete the subject from core data
        let subjectObject: NSManagedObject! = self.managedObjectContext.object(with: selectedSubject.id)
        
        let fetchHomeworkRequest = NSFetchRequest<NSManagedObject>(entityName: "HomeworkEntity")
        let homeworksPredicate = NSPredicate(format: "subject == %@", (subjectObject.objectID))
        fetchHomeworkRequest.predicate = homeworksPredicate
        var savedHomeworks: [NSManagedObject]!
        do {
            savedHomeworks = try self.managedObjectContext.fetch(fetchHomeworkRequest) }
        catch {
            print("getHomeowkrs classes error: \(error)")
        }
        
        for homework in savedHomeworks {
            
            self.managedObjectContext.delete(homework)
        }
        self.managedObjectContext.delete(subjectObject)
        self.appDelegate.saveContext()
        
        
        // 2. delete the subjcet cell at that index path from the collectionview
        listOfClasses.remove(at: rowNumber)
        self.collectionView?.reloadData()
    }
    
    @IBAction func unwindFromAddClass (sender: UIStoryboardSegue) {
        let addSubjectVC = sender.source as! AddNewClassViewController
        let subjectName = addSubjectVC.subjectName
        let subjectColor = getRandomColor()
        listOfClasses.append(Subject(pTitle: subjectName, pColor: subjectColor))
        listOfClasses.last?.id = addClassToCoreData(className: subjectName, color: subjectColor)
        self.collectionView?.reloadData()
    }
    
}
 
 extension ClassesViewController : SubjectCellDelegate {
    func delete(cell: ClassesCollectionViewCell){
        if let indexPath = collectionView?.indexPath(for: cell){
            let selectedSubject = listOfClasses[indexPath.row]
            let alert = UIAlertController(title: "Are you sure you want to delete \(selectedSubject.title)", message: "This will also delete all homeworks.", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
                // 1. delete the subject from core data
                self.deleteFromCoreData(rowNumber: indexPath.row)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            
            alert.addAction(okayAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil) 
        }
    }
 }
 
 
 
