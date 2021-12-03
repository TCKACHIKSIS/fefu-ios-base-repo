//
//  CollectionViewCellStartTracking.swift
//  fefuactivity
//
//  Created by иван on 03.12.2021.
//

import UIKit

class CollectionViewCellStartTracking: UICollectionViewCell {
    @IBOutlet weak var activity_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
    }
    
}
