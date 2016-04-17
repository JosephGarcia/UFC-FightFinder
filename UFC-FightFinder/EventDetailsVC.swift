
//
//  EventDetailsVC.swift
//  UFC-FightFinder
//
//  Created by Joseph Garcia on 4/16/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit
import Alamofire
import DZNEmptyDataSet

class EventDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource  {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventHeadliner: UILabel!
    @IBOutlet weak var provider: UILabel!
    
    var event: Event!
    
    var fightCard = [Bout]()
    
    
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
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self
        
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
            let result = response.result
            if let bouts = result.value as? [Dictionary<String, AnyObject>] {
                for bout in bouts {
                    // IN THE FUTURE HANDLE URLS WITH DIFFERENT API STRUCTURE
                    if let _ = bout["version"] as? Int {
                        // do nothing
                    } else {
                    // FIGHTER 1 DATA
                        let fighter1Image = bout["fighter1_profile_image"] as! String
                        let fighter1FirstName = bout["fighter1_first_name"] as! String
                        let fighter1LastName = bout["fighter1_last_name"] as! String
                        let fighter1FullName = "\(fighter1FirstName) \(fighter1LastName)"
                        // FIGHTER 2 DATA
                        let fighter2Image = bout["fighter2_profile_image"] as! String
                        let fighter2FirstName = bout["fighter2_first_name"] as! String
                        let fighter2LastName = bout["fighter2_last_name"] as! String
                        let fighter2FullName = "\(fighter2FirstName) \(fighter2LastName)"
                        
                        let bout = Bout(fighter1: fighter1FullName, fighter1Img: fighter1Image, fighter2: fighter2FullName, fighter2Img: fighter2Image)
                        self.fightCard.append(bout)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("boutCell", forIndexPath: indexPath) as! BoutCell
        
        let bout: Bout
        
        bout = fightCard[indexPath.row]
        
        cell.configureCell(bout)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fightCard.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
//    func backgroundColorForEmptyDataSet(scrollView: UIScrollView!) -> UIColor! {
//        return UIColor
//    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let stringColor = [NSForegroundColorAttributeName: UIColor.blackColor()]
        let emptyDesc = NSAttributedString(string: "We're sorry, but the fight card for \(event.headliner) does not seem to be completely set up yet. Please check again later.", attributes: stringColor )
        
       return emptyDesc
    }
}
