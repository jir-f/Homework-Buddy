//
//  AddNewClassViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 4/8/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit

class AddNewClassViewController: UIViewController {

    @IBOutlet weak var classTextField: UITextField!
    
    @IBAction func addNewClassButton(_ sender: Any) {
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Class"
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
