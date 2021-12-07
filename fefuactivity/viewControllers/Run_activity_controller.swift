//
//  Run_activity_controller.swift
//  fefuactivity
//
//  Created by иван on 07.12.2021.
//

import UIKit

class Run_activity_controller: UIViewController {

    @IBOutlet weak var time_of_activity: UILabel!
    @IBOutlet weak var distance_activity: UILabel!
    @IBOutlet weak var type_activity: UILabel!
    let formatter: DateFormatter = {
            let tmpFormatter = DateFormatter()
            tmpFormatter.dateFormat = "hh:mm a"
            return tmpFormatter
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
