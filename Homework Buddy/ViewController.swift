//
//  ViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/20/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UITabBarController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
        UIApplication.shared.applicationIconBadgeNumber = 0
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

