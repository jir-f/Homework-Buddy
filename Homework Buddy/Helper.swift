//
//  Helper.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 4/12/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import Foundation
import UIKit

class Helper{
    static func converToDate(input: String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: input)
        
        if(date != nil){
            return date
        }
        else{
            return nil
        }
    }
    
    static func monthFormatter(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM";
        
        let month = dateFormatter.string(from: date as Date)
        
        return month
    }
    
    static func dayFormatter(date: Date) -> String{
    let dayFormatter = DateFormatter()
    dayFormatter.dateFormat = "dd"
    
    let day = dayFormatter.string(from: date as Date)
    
    return day
    }
    
    
    static func convertToString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.string(from: date)
        
        return date
    }
    
    static func dateToDateHours(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        let result = dateFormatter.string(from: date)
        
        return result
    }
    
    static func getTime(date: Date)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        let result = dateFormatter.string(from: date)
        
        return result
    }
    
    static func sortHomework(homeworkList: [Homework]) -> [Homework]{
        return homeworkList.sorted(by: { $0.dueDate < $1.dueDate })
    }
    
}

