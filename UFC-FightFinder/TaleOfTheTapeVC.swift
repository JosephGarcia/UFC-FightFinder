//
//  TaleOfTheTapeVCViewController.swift
//  UFC-FightFinder
//
//  Created by Joseph Garcia on 4/18/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit

class TaleOfTheTapeVC: UIViewController {
    //FIGHTER 1
    @IBOutlet weak var fighter1Image: UIImageView!
    @IBOutlet weak var fighter1Record: UILabel!
    @IBOutlet weak var fighter1Height: UILabel!
    @IBOutlet weak var fighter1Weight: UILabel!
    @IBOutlet weak var fighter1Rank: UILabel!
    @IBOutlet weak var fighter1Name: UILabel!
    
    //FIGHTER 2
    @IBOutlet weak var fighter2Image: UIImageView!
    @IBOutlet weak var fighter2Record: UILabel!
    @IBOutlet weak var fighter2Height: UILabel!
    @IBOutlet weak var fighter2Weight: UILabel!
    @IBOutlet weak var fighter2Name: UILabel!
    @IBOutlet weak var fighter2Rank: UILabel!
    
    var bout : Bout!
    let ranked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        //FIGHTER 1
        if let fighter1body = bout.fighter1BodyImage {
            fighter1Image.kf_setImageWithURL(NSURL(string: fighter1body)!, placeholderImage: UIImage(named: "fighter_placeholder"))
        }
        fighter1Record.text = bout.fighter1record
        fighter1Height.text = "\(bout.fighter1Height)"
        fighter1Weight.text = "\(bout.fighter1weight)"
        fighter1Name.text = bout.fighter1Name
        fighter1Rank.text = "#\(bout.fighter1Rank)"
        
        //FIGHTER 2
        if let fighter2body = bout.fighter2BodyImage {
            fighter2Image.kf_setImageWithURL(NSURL(string: fighter2body)!, placeholderImage: UIImage(named: "fighter_placeholder"))
        }
        fighter2Record.text = bout.fighter2record
        fighter2Height.text = "\(bout.fighter2Height)"
        fighter2Weight.text = "\(bout.fighter2weight)"
        fighter2Name.text = bout.fighter2Name
        fighter2Rank.text = "#\(bout.fighter2Rank)"
        
        self.checkRank()
        self.exitOnTap()
        
    }
    
    func checkRank(){
        if bout.fighter1Rank == nil {
            fighter1Rank.hidden = true
        }
        
        if bout.fighter2Rank == nil {
            fighter2Rank.hidden = true
        }
    }
    
    func exitOnTap(){
        let screenTapped = UITapGestureRecognizer(target: self, action: "exitScreen:")
        screenTapped.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(screenTapped)
        self.view.userInteractionEnabled = true
    }
    
    func exitScreen(gesture: UIGestureRecognizer){
        dismissViewControllerAnimated(true, completion: nil)
    }
}
