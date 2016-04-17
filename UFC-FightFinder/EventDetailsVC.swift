
//
//  EventDetailsVC.swift
//  UFC-FightFinder
//
//  Created by Joseph Garcia on 4/16/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit
import Alamofire

class EventDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventHeadliner: UILabel!
    @IBOutlet weak var provider: UILabel!
    
    var event: Event!
    
    @IBAction func backBarItem_clicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Assigning Detail View Content
        eventHeadliner.text = event.headliner
        eventDescription.text = event.titleDescription
        provider.text = event.eventProvider
        
        //Setting up Tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        //Setting Image
        let posterUrl = NSURL(string: event.eventImage)
        let data = NSData(contentsOfURL: posterUrl!)
        eventImage.image = UIImage(data: data!)
        
        //Getting Fightcard
        self.getFightcard()
    }
    
    func getFightcard(){
        let fightcard_url = "\(UFC_BASE_URL)/v3/iphone/events/\(event.eventId)/fights"
        print(fightcard_url)
        Alamofire.request(.GET, fightcard_url).responseJSON { (response ) -> Void in
            print(response)
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("boutCell", forIndexPath: indexPath) as! BoutCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
