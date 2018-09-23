//
//  CollectionViewCell.swift
//  HasbroSTransformers
//
//  Created by Pooya on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//

import UIKit
    
    protocol DataCollectionProtocol {
        func passData(index : Int)
        func deleteData(index : Int)
    }
    
    
class CollectionViewCell: UICollectionViewCell {
        
        @IBOutlet weak var cellImage: UIImageView!
        @IBOutlet weak var cellEditBtn: UIButton!
        @IBOutlet weak var cellDeleteBtn: UIButton!
        @IBOutlet weak var cellTitle: UILabel!
        @IBOutlet weak var cellDetails: UILabel!
        @IBOutlet weak var leftCellImage: UIImageView!
        @IBOutlet weak var rightCellImage: UIImageView!
    
    var delegate : DataCollectionProtocol?
        var index : IndexPath?
        
        @IBAction func editBtn(_ sender: UIButton) {
            delegate?.passData(index: (index?.row)!)
        }
        
        
        @IBAction func deleteBtn(_ sender: UIButton) {
            delegate?.deleteData(index: (index?.row)!)
        }
    
    
    
}
