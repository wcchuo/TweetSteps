//
//  Steps.swift
//  TweetSteps
//
//  Created by Wei Chung Chuo on 8/17/15.
//  Copyright © 2015 Wei Chung Chuo. All rights reserved.
//

import UIKit
import CoreMotion

class StepsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let pedometer: CMPedometer = CMPedometer()
    
    
    @IBOutlet weak var stepCount: UILabel!
    
    @IBAction func resetButtonPressed(sender: UIButton) {
        pedometer.stopPedometerUpdates()
        stepCount.text = "0"
    }
    @IBAction func startButtonPressed(sender: UIButton) {
        pedometer.startPedometerUpdatesFromDate(NSDate(), withHandler: { data, error in
            print("Update \(data!.numberOfSteps)")
            dispatch_async(dispatch_get_main_queue()) {
                self.stepCount.text = String(stringInterpolationSegment: data!.numberOfSteps)
            }
        })
    }
    
    
    
}
