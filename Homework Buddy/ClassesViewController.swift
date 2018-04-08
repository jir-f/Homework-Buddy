 //
//  ClassesViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/22/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit

class ClassesViewController: UICollectionViewController {
    var listOfClasses = [Subject]()
    var selectedRow = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        initClasses()
    }
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // 1
//        return 1
//    }
//
    func initClasses(){
        var bio = Subject(pTitle: "Biology")
        bio.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: NSDate()))
        listOfClasses.append(bio)
        
        for i in 1...20 {
            bio.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: NSDate()))
        }
        
        
        var mth = Subject(pTitle: "Math")
        mth.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: NSDate()))
        listOfClasses.append(mth)
        
        var phy = Subject(pTitle: "Physics")
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
    
}
