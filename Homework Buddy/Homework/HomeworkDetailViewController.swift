//
//  HomeworkDetailViewController.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 4/28/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit

class HomeworkDetailViewController: UIViewController, UINavigationBarDelegate{

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var completeButton: UIButton!
    
    @IBAction func completeButtonAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Completed Homework \(self.passedTitle)", message: "", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
            //run your function here
            self.performSegue(withIdentifier: "BackToToday", sender: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    var navTitle = ""
    var passedTitle = ""
    var passedDescription = ""
    var passedDueDate = ""
    var color = UIColor()
    
    var gradientLayer: CAGradientLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeButton.backgroundColor = self.color
        completeButton.layer.cornerRadius = 4
        completeButton.setTitleColor(UIColor.white, for: .normal)
        
        createGradientLayer()
        
        navigationItem.title = navTitle
        
        titleLabel.text = passedTitle
        descriptionLabel.text = passedDescription
        dueDateLabel.text = passedDueDate
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, self.color.cgColor]
        
//        self.view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        
    }
    

}
