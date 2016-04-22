//
//  Bout.swift
//  UFC-FightFinder
//
//  Created by Joseph Garcia on 4/17/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import Foundation

class Bout {
    //IMAGE AND NAME PLACEHOLDERS
    private var _fighter1Name: String!
    private var _fighter1Img: String!
    private var _fighter2Name: String!
    private var _fighter2Img: String!
    
    //FIGHTER STATS
    internal var fighter1reach: Int!
    internal var fighter1weight: Int!
    internal var fighter1record: String!
    internal var fighter1Height: Int!
    internal var fighter1Rank: String!
    internal var fighter1BodyImage: String!
    internal var fighter2reach: Int!
    internal var fighter2weight: Int!
    internal var fighter2record: String!
    internal var fighter2Height: Int!
    internal var fighter2Rank: String!
    internal var fighter2BodyImage: String!
    
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
        self.fighter1reach = 0
    }

}

class FighterOne {
    private var _name: String!
    private var _image: String!
    
    var name: String {
        return _name
    }
    
    var image: String {
        return _image
    }
    
    init(name: String, image: String) {
        self._name = name
        self._image = image
    }
}

class FighterTwo {
    private var _name: String!
    private var _image: String!
    
    var name: String {
        return _name
    }
    
    var image: String {
        return _image
    }
    
    init(name: String, image: String) {
        self._name = name
        self._image = image
    }
}