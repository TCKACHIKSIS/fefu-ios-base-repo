//
//  Active_activity.swift
//  fefuactivity
//
//  Created by иван on 07.12.2021.
//

import UIKit

class Active_activity: UIView {
    let formatter = DateFormatter()
    var timer: Timer?
    var current_date = Date()
    var full_saved_time: DateComponents?
    var current_saved_time: DateComponents?
    var selected_type_activity: String?
    @IBOutlet weak var time_of_activity: UILabel!
    @IBOutlet weak var distance_of_activity: UILabel!
    @IBOutlet weak var type_activity: UILabel!
    @IBOutlet weak var continue_button: UIButton!
    @IBOutlet weak var pause_button: UIButton!
    @IBAction func pause_activity(_ sender: Any) {
        timer?.invalidate()
        let parent = self.parentViewController as! LocationTrackingView
        parent.pause_track_location()
        pause_button.isHidden = true
        continue_button.isHidden = false
    }
    @IBAction func continue_tracking(_ sender: Any) {
        full_saved_time = current_saved_time
        current_date = Date()
        createTimer()
        let parent = self.parentViewController as! LocationTrackingView
        parent.continue_updating_location()
        continue_button.isHidden = true
        pause_button.isHidden = false
    }
    func setSelectedType(type: String){
        self.selected_type_activity = type
    }
    @IBAction func finish_activity(_ sender: Any) {
        timer?.invalidate()
        let parent = self.parentViewController as! LocationTrackingView
        parent.finish_activity()
    }
    override func awakeFromNib(){
        super.awakeFromNib()
        continue_button.isHidden = true
        createTimer()
    }
    func updateDistance(text: String){
        distance_of_activity.text = text
    }
}

extension Active_activity{
    @objc func updateTimer(){
        type_activity.text = self.selected_type_activity
        let userCalendar = Calendar.current
        let requestedComponent: Set<Calendar.Component> = [.hour,.minute,.second]
        var timeDifference = userCalendar.dateComponents(requestedComponent, from: current_date, to: Date())
        var ptr = ""
        if full_saved_time != nil {
            timeDifference.second = timeDifference.second! + (full_saved_time?.second)! as Int
        }
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
        current_saved_time = timeDifference
        time_of_activity.text = ptr.description
    }
    func createTimer() {
    formatter.dateFormat = "MM/dd/yyyy"
    timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
}
