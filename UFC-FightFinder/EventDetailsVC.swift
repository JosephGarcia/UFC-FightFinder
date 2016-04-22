
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
        eventDescription.text = event.titleDescription
        provider.text = event.eventProvider
        
        //Setting up Tableview
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self
        
        //Setting Image
        let posterUrl = NSURL(string: event.eventImage)
        eventImage.kf_setImageWithURL(posterUrl!, placeholderImage: UIImage(named: "fightnight"))
        
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
                        //FIGHTER 1 STATS
                        let fighter1Reach = bout["fighter1reach"] as? Int
                        let fighter1weight = bout["fighter1weight"] as! Int
                        let fighter1record = bout["fighter1record"] as! String
                        let fighter1Height = bout["fighter1height"] as! Int
                        let fighter1Rank = bout["fighter1_rank"] as? String
                        let fighter1BodyImage = bout["fighter1_full_body_image"] as? String
                        
                        // FIGHTER 2 DATA
                        let fighter2Image = bout["fighter2_profile_image"] as! String
                        let fighter2FirstName = bout["fighter2_first_name"] as! String
                        let fighter2LastName = bout["fighter2_last_name"] as! String
                        let fighter2FullName = "\(fighter2FirstName) \(fighter2LastName)"
                        //FIGHTER 2 STATS
                        let fighter2Reach = bout["fighter2reach"] as? Int
                        let fighter2weight = bout["fighter2weight"] as! Int
                        let fighter2record = bout["fighter2record"] as! String
                        let fighter2Height = bout["fighter2height"] as! Int
                        let fighter2Rank = bout["fighter2_rank"] as? String
                        let fighter2BodyImage = bout["fighter2_full_body_image"] as? String
                        
                        let bout = Bout(fighter1: fighter1FullName, fighter1Img: fighter1Image, fighter2: fighter2FullName, fighter2Img: fighter2Image)
                        // FIGHTER 1 STATS
                        bout.fighter1reach = fighter1Reach
                        bout.fighter1weight = fighter1weight
                        bout.fighter1record = fighter1record
                        bout.fighter1Height = fighter1Height
                        bout.fighter1Rank = fighter1Rank
                        bout.fighter1BodyImage = fighter1BodyImage
                        
                        // FIGHTER 2 STATS
                        bout.fighter2reach = fighter2Reach
                        bout.fighter2weight = fighter2weight
                        bout.fighter2record = fighter2record
                        bout.fighter2Height = fighter2Height
                        bout.fighter2Rank = fighter2Rank
                        bout.fighter2BodyImage = fighter2BodyImage
                        
                        // STORE
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
        let bout: Bout
        
        bout = fightCard[indexPath.row]
        
        performSegueWithIdentifier(TALE_OF_THE_TAPE, sender: bout)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == TALE_OF_THE_TAPE {
            if let detailsVC = segue.destinationViewController as? TaleOfTheTapeVC {
                if let boutData = sender as? Bout {
                    detailsVC.bout = boutData
                }
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let stringColor = [NSForegroundColorAttributeName: UIColor.blackColor()]
        let emptyDesc = NSAttributedString(string: "We're sorry, but the fight card for \(event.headliner) does not seem to be completely set up yet. Please check again later.", attributes: stringColor )
        
       return emptyDesc
    }
}
