//
//  BoutCell.swift
//  UFC-FightFinder
//
//  Created by Joseph Garcia on 4/17/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit

class BoutCell: UITableViewCell {
    
    @IBOutlet weak var fighter1Img: UIImageView!
    @IBOutlet weak var fighter1Name: UILabel!
    @IBOutlet weak var fighter2Img: UIImageView!
    @IBOutlet weak var fighter2Name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(bout: Bout){
        fighter1Name.text = bout.fighter1Name
        fighter2Name.text = bout.fighter2Name
        
        let fighter1URL = NSURL(string: bout.fighter1Img)
        let fighter1Data = NSData(contentsOfURL: fighter1URL!)
        fighter1Img.image = UIImage(data: fighter1Data!)
        
        let fighter2URL = NSURL(string: bout.fighter2Img)
        let fighter2Data = NSData(contentsOfURL: fighter2URL!)
        fighter2Img.image = UIImage(data: fighter2Data!)
    }
}
