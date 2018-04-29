//
//  Subject.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/30/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Subject{
    var title: String;
    var homeworks = [Homework]();
    var color: UIColor
    var id: NSManagedObjectID
    
    init(pTitle: String, pColor: UIColor){
        self.title = pTitle;
        id = NSManagedObjectID.init()
        self.color = pColor
    }
    
}
