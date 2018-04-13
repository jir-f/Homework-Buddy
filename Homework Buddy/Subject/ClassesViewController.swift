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
    var listOfClasses = [Subject]()
    
    var selectedRow = 0
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        collectionView?.backgroundColor = UIColor.white
        
        getClasses()
        
        initClasses()
        
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
            let subjectId = subject.objectID as NSManagedObjectID
            let subjectColor = subject.value(forKey: "color") as! UIColor
            let newSubject = Subject(pTitle: subjectName, pId: subjectId, pColor: subjectColor)
            newSubject.id = subject.objectID as NSManagedObjectID
            listOfClasses.append(newSubject)
        }
    }
    
    func initClasses(){
        var bio = Subject(pTitle: "Biology", pId: NSManagedObjectID.init(), pColor: getRandomColor())
        bio.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: Date()))
        listOfClasses.append(bio)
        
        for i in 1...5 {
            bio.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: Date()))
        }
        
        
        var mth = Subject(pTitle: "Math", pId: NSManagedObjectID.init(), pColor: getRandomColor())
        mth.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: Date()))
        listOfClasses.append(mth)
        
        var phy = Subject(pTitle: "Physics", pId: NSManagedObjectID.init(), pColor: getRandomColor())
        phy.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: Date()))
        listOfClasses.append(phy)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfClasses.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "classCell", for: indexPath)
        
        cell.backgroundColor = listOfClasses[indexPath.row].color
        
        let label = cell.viewWithTag(1) as! UILabel
        
        cell.layer.cornerRadius = 10.0
        
        label.text = listOfClasses[indexPath.row].title
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "classDetail", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "classDetail"){
            let classDetailVC = segue.destination as! ClassDetailViewController
            classDetailVC.navTitle = self.listOfClasses[selectedRow].getTitle()
            classDetailVC.classHomewroks = self.listOfClasses[selectedRow].getHomeworks()
//            print(self.listOfClasses[selectedRow].id)
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
    
    @IBAction func unwindFromAddClass (sender: UIStoryboardSegue) {
        let addSubjectVC = sender.source as! AddNewClassViewController
        let subjectName = addSubjectVC.subjectName
        let subjectColor = getRandomColor()
        let subjectId = addClassToCoreData(className: subjectName, color: subjectColor)
        listOfClasses.append(Subject(pTitle: subjectName, pId: subjectId, pColor: subjectColor))
        self.collectionView?.reloadData()
    }
    
}
