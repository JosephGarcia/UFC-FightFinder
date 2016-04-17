//
//  BoutCell.swift
//  UFC-FightFinder
//
//  Created by Joseph Garcia on 4/17/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit
import Kingfisher

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
        let task1 = fighter1Img.kf_setImageWithURL(fighter1URL!, placeholderImage: nil, optionsInfo: [.ForceRefresh])
        if task1.downloadTask?.URL != fighter1URL {
            task1.cancel()
        }
        
        let fighter2URL = NSURL(string: bout.fighter2Img)
        let task2 = fighter2Img.kf_setImageWithURL(fighter2URL!, placeholderImage: nil, optionsInfo: [.ForceRefresh])
        if task2.downloadTask?.URL != fighter2URL {
            task2.cancel()
        }
        
    }
}
