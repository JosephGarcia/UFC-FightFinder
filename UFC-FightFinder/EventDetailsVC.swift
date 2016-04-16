//
//  EventDetailsVC.swift
//  UFC-FightFinder
//
//  Created by Joseph Garcia on 4/16/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit

class EventDetailsVC: UIViewController {

    @IBOutlet weak var eventHeadliner: UILabel!
    var event: Event!
    
    @IBAction func backBarItem_clicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        eventHeadliner.text = event.headliner
    }
}
