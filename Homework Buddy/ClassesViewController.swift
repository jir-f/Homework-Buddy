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
            let newSubject = Subject(pTitle: subjectName, pId: subjectId)
            listOfClasses.append(newSubject)
        }
    }
    
    func initClasses(){
        var bio = Subject(pTitle: "Biology", pId: NSManagedObjectID.init())
        bio.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: NSDate()))
        listOfClasses.append(bio)
        
        for i in 1...20 {
            bio.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: NSDate()))
        }
        
        
        var mth = Subject(pTitle: "Math", pId: NSManagedObjectID.init())
        mth.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: NSDate()))
        listOfClasses.append(mth)
        
        var phy = Subject(pTitle: "Physics", pId: NSManagedObjectID.init())
        phy.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: NSDate()))
        listOfClasses.append(phy)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfClasses.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "classCell", for: indexPath)
        
        cell.backgroundColor = getRandomColor()
        
        var label = cell.viewWithTag(1) as! UILabel
        
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
        }
    }
    
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
    func addClassToCoreData(className: String) -> NSManagedObjectID{
        let subject = NSEntityDescription.insertNewObject(forEntityName:
            "SubjectEntity", into: self.managedObjectContext)
        subject.setValue(className, forKey: "name")
        self.appDelegate.saveContext()
        return subject.objectID
    }
    
    @IBAction func unwindFromAddClass (sender: UIStoryboardSegue) {
        let addSubjectVC = sender.source as! AddNewClassViewController
        let subjectName = addSubjectVC.subjectName
        let subjectId = addClassToCoreData(className: subjectName)
        listOfClasses.append(Subject(pTitle: subjectName, pId: subjectId))
        self.collectionView?.reloadData()
    }
    
}
