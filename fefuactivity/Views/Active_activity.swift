//
//  Active_activity.swift
//  fefuactivity
//
//  Created by иван on 07.12.2021.
//

import UIKit

class Active_activity: UIView {

    @IBOutlet weak var time_of_activity: UILabel!
    @IBOutlet weak var distance_of_activity: UILabel!
    @IBOutlet weak var type_activity: UILabel!
    @IBOutlet weak var continue_button: UIButton!
    @IBOutlet weak var pause_button: UIButton!
    
    @IBAction func pause_activity(_ sender: Any) {
        let parent = self.parentViewController as! LocationTrackingView
        parent.pause_track_location()
        pause_button.isHidden = true
        continue_button.isHidden = false
    }
    @IBAction func continue_tracking(_ sender: Any) {
        let parent = self.parentViewController as! LocationTrackingView
        parent.continue_updating_location()
        continue_button.isHidden = true
        pause_button.isHidden = false
    }
    @IBAction func finish_activity(_ sender: Any) {
        let parent = self.parentViewController as! LocationTrackingView
        parent.finish_activity()
    }
    override func awakeFromNib(){
        super.awakeFromNib()
        continue_button.isHidden = true
    }
}
