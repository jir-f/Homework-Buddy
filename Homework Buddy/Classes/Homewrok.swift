//
//  Homewrok.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/22/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Homework{
    var title: String;
    var description: String;
    var dueDate: Date;
    var id: NSManagedObjectID
    var color: UIColor
    var subject: String;
    
    init(pTitle: String, pDescription: String, pDueDate: Date){
        self.title = pTitle;
        self.description = pDescription;
        self.dueDate = pDueDate;
        self.id = NSManagedObjectID.init()
        self.color = UIColor()
        self.subject = ""
    }
}
