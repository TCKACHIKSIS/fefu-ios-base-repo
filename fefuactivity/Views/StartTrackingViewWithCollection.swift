//
//  StartTrackingViewWithCollection.swift
//  fefuactivity
//
//  Created by иван on 03.12.2021.
//

import UIKit

class StartTrackingViewWithCollection: UIView {
    var current_selected_activity: String = ""
    var current_selected_cell = IndexPath()
    var lol_kek = ["Велосипед", "Бег"]
    @IBOutlet weak var collection_view: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collection_view.register(UINib(nibName: "CollectionViewCellStartTracking", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCellStartTracking")
        self.collection_view.dataSource = self
        self.collection_view.delegate = self
        collection_view.delaysContentTouches = false
    }
}

extension StartTrackingViewWithCollection: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
                // In this function is the code you must implement to your code project if you want to change size of Collection view
        let width  = ((self.window?.frame.size.width)!-20)/3
        return CGSize(width: width, height: width / 2.5)
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellStartTracking", for: indexPath) as! CollectionViewCellStartTracking
        cell.activity_label.text = lol_kek[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCellStartTracking
        if current_selected_cell != IndexPath(row: NSNotFound, section: NSNotFound)
        {
            collectionView.cellForItem(at: current_selected_cell)?.layer.borderWidth = 0
        }
        current_selected_cell = indexPath
        current_selected_activity = cell.activity_label.text!
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.blue.cgColor
    }
}
