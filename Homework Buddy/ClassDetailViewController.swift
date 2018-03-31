//
//  ClassDetailViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/30/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit

class ClassDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listOfHomework: UITableView!
    
    var classHomewroks = [Homework]();
    var navTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfHomework.delegate = self
        listOfHomework.dataSource = self
        
        navigationItem.title = navTitle
        
        
        self.listOfHomework.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return self.classHomewroks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classHomeworkCell", for: indexPath)
        
        let row = indexPath.row
        
        cell.textLabel?.text = classHomewroks[row].title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        ;
        
        cell.detailTextLabel?.text = dateFormatter.string(from: classHomewroks[row].dueDate as Date)
        
        return cell
        
    }
    
    func displayHomewroks(){
        
    }

}
