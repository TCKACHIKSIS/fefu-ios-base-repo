//
//  Active_activity.swift
//  fefuactivity
//
//  Created by иван on 07.12.2021.
//

import UIKit


protocol Active_activityDelegate: AnyObject {
    func updateDistance(text: String)
}

class Active_activity: UIView, Active_activityDelegate {
    let formatter = DateFormatter()
    var timer: Timer?
    var current_date = Date()
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
        createTimer()
        super.awakeFromNib()
        continue_button.isHidden = true
    }
    func updateDistance(text: String){
        distance_of_activity.text = text
    }
}

extension Active_activity{
    @objc func updateTimer(){
        let userCalendar = Calendar.current
        let requestedComponent: Set<Calendar.Component> = [.hour,.minute,.second]
        let timeDifference = userCalendar.dateComponents(requestedComponent, from: current_date, to: Date())
        var ptr = ""
        if ( timeDifference.hour != 0 ){
            ptr += timeDifference.hour?.description ?? "??"
            ptr += "ч "
        }
        if ( timeDifference.minute != 0 ){
            ptr += timeDifference.minute?.description ?? "??"
            ptr += "м"
        }
        if ( timeDifference.second != 0 ){
            ptr += timeDifference.second?.description ?? "??"
            ptr += "c"
        }
        
        time_of_activity.text = ptr.description
    }
    func createTimer() {
    formatter.dateFormat = "MM/dd/yyyy"
      if timer == nil {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
      }
    }
}
