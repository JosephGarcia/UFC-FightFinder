//
//  EventCell.swift
//  UFC-FightFinder
//
//  Created by Joseph Garcia on 4/5/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    let SHADOW_COLOR: CGFloat = 157.0 / 255.0
    
    @IBOutlet weak var eventHeadliner: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventImg: UIImageView!
    
    var event: Event!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 7.0
        layer.masksToBounds = false;
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 6.0
        layer.shadowOffset = CGSizeMake(0.0, 3.0)
    }
    
    func configureCell(event: Event) {
        self.event = event
        
        eventHeadliner.text = self.event.headliner
        eventName.text = self.event.name
        if self.event.eventImage != "" {
            let posterUrl =  NSURL(string: self.event.eventImage)
            let data = NSData(contentsOfURL: posterUrl!)
            eventImg.contentMode = .ScaleAspectFit
            eventImg.image = UIImage(data: (data!))
        } else {
            eventImg.image = UIImage(named: "fightnight")
        }
    }
}
