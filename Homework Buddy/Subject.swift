//
//  Subject.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/30/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import Foundation

class Subject{
    var title: String;
    var homeworks = [Homework]() ;
    
    init(pTitle: String){
        self.title = pTitle;
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
