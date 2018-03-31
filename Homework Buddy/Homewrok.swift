//
//  Homewrok.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/22/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import Foundation

class Homework{
    var title: String;
    var description: String;
    var dueDate: NSDate;
    
    init(pTitle: String, pDescription: String, pDueDate: NSDate){
        self.title = pTitle;
        self.description = pDescription;
        self.dueDate = pDueDate;
    }
    
    func getTitle() -> String{
        return self.title
    }
    
    func getDescription() -> String {
        return self.description
    }
    
    func getDueDate() -> NSDate {
        return self.dueDate
    }
}