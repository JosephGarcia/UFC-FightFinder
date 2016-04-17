//
//  Bout.swift
//  UFC-FightFinder
//
//  Created by Joseph Garcia on 4/17/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import Foundation

class Bout {
    
    private var _fighter1Name: String!
    private var _fighter1Img: String!
    private var _fighter2Name: String!
    private var _fighter2Img: String!
    
    
    var fighter1Name: String {
        return _fighter1Name
    }
    
    var fighter1Img: String {
     return _fighter1Img
    }
    
    var fighter2Name: String {
        return _fighter2Name
    }
    
    var fighter2Img: String {
        return _fighter2Img
    }
    
    init(fighter1: String , fighter1Img: String, fighter2: String, fighter2Img: String) {
        self._fighter1Name = fighter1
        self._fighter1Img = fighter1Img
        self._fighter2Name = fighter2
        self._fighter2Img = fighter2Img
    }

}