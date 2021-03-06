//
//  ViewController.swift
//  UFC-FightFinder
//
//  Created by Joseph Garcia on 4/4/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftDate

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var ufcEvents = [Event]()
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collection.delegate = self
        collection.dataSource = self
        self.grabAllEvents()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func grabAllEvents(){
        Alamofire.request(.GET, UFC_EVENTS_URL).responseJSON { (response) -> Void in
            let result = response.result
            if let events = result.value as? [Dictionary<String,AnyObject>] {
                for event in events {
                    let actualDate = event["event_date"] as! String
                    var fightDate = actualDate.toDate(DateFormat.ISO8601) as NSDate!
                    // IF FIGHT IS TODAY OR UPCOMING!
                    if fightDate >= NSDate.yesterday() {
                        // NEED TO EXTRACT CITY NAME AND APPEND TO FIGHT NIGHT
                        let location = String(event["location"]!) //  "Miami, Florida"
                        let cityState = location.componentsSeparatedByString(",") // ["Miami", "Florida"]
                        let city = cityState[0]
                        var eventName = String(event["base_title"]!)
                        
                        if eventName == "UFC Fight Night" && city != "" {
                            eventName = "UFC Fight Night: \(city)"
                        }
                        
                        let imageUrl = String(event["feature_image"]!)
                        let eventId = event["id"]!.integerValue
                        let headliner = String(event["title_tag_line"]!)
                        let description = String(event["short_description"]!)
                        let provider = String(event["subtitle"]!)
                        
                        let ufcEvent = Event(name: eventName, eventId: eventId, headliner: headliner, url: imageUrl, description: description, provider: provider)
                        self.storeEvents(ufcEvent)
                    }
                }
            }
        }
    }
    
    func storeEvents(event: Event){
        ufcEvents.append(event)
        collection.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(450, 230)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let upcomingEvent: Event
        
        upcomingEvent = ufcEvents[indexPath.row]
        
        performSegueWithIdentifier(SHOW_DETAILS, sender: upcomingEvent)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EventCell", forIndexPath: indexPath) as? EventCell {
            
            let upcomingEvent: Event
            
            upcomingEvent = ufcEvents[indexPath.row]
           
            
            cell.configureCell(upcomingEvent)
         return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ufcEvents.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SHOW_DETAILS {
            if let detailsVC = segue.destinationViewController as? EventDetailsVC {
                if let fightNight = sender as? Event {
                    detailsVC.event = fightNight
                }
            }
        }
    }


}

