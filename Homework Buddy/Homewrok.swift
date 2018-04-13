//
//  Homewrok.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/22/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import Foundation
import CoreData

class Homework{
    var title: String;
    var description: String;
    var dueDate: Date;
    var id: NSManagedObjectID
    
    init(pTitle: String, pDescription: String, pDueDate: Date){
        self.title = pTitle;
        self.description = pDescription;
        self.dueDate = pDueDate;
        self.id = NSManagedObjectID.init()
    }
    
    func getTitle() -> String{
        return self.title
    }
    
    func getDescription() -> String {
        return self.description
    }
    
    func getDueDate() -> Date {
        return self.dueDate
    }
}
