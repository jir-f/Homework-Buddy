 //
//  ClassesViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/22/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit

 var listOfClasses = [Subject]()
 
class ClassesViewController: UICollectionViewController {
    
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
        
        var mth = Subject(pTitle: "Math")
        bio.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: NSDate()))
        listOfClasses.append(mth)
        
        var phy = Subject(pTitle: "Physics")
        bio.addHomeowrk(pHomework: Homework(pTitle: "homework 1", pDescription: "Read chapter 1", pDueDate: NSDate()))
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
    
    func getRandomColor() -> UIColor{
        
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
}
