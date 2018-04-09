//
//  AddNewHomeworkViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 4/8/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit

class AddNewHomeworkViewController: UIViewController {

    @IBOutlet weak var homeworkTitle: UITextField!
    
    @IBOutlet weak var homewrokDescription: UITextField!
    
    @IBOutlet weak var homeworkDueDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Homework"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
