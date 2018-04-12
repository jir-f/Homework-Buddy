//
//  Subject.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/30/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import Foundation
import CoreData

class Subject{
    var title: String;
    var homeworks = [Homework]();
    var id: NSManagedObjectID
    
    init(pTitle: String, pId: NSManagedObjectID){
        self.title = pTitle;
        id = NSManagedObjectID.init()
    }
    
    func getTitle() -> String{
        return self.title
    }
    
    func addHomeowrk(pHomework: Homework) {
        self.homeworks.append(pHomework)
    }
    
    func getHomeworks() -> [Homework] {
        return self.homeworks
    }
    
}
