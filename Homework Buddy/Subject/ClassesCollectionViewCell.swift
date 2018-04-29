//
//  ClassesCollectionViewCell.swift
//  Homework Buddy
//
//  Created by Jiro Farah on 3/29/18.
//  Copyright © 2018 Jiro Farah. All rights reserved.
//

import UIKit

protocol SubjectCellDelegate: class {
    func delete(cell: ClassesCollectionViewCell)
}

class ClassesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deleteCellView: UIVisualEffectView!
    
    @IBOutlet weak var subjectName: UILabel!
    
    weak var delegate: SubjectCellDelegate?
    
    var subject: String!{
        didSet{
            subjectName.text = subject
            deleteCellView.layer.cornerRadius = (deleteCellView.bounds.width) / 2.0
            deleteCellView.layer.masksToBounds = true
            deleteCellView.isHidden = !isEditing
        }
    }
    
    var isEditing: Bool = false {
        didSet{
            deleteCellView.isHidden = !isEditing
        }
    }
    @IBAction func deleteButton(_ sender: Any) {
        delegate?.delete(cell: self)
    }
}
