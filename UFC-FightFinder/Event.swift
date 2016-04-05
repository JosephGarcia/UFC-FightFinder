//
//  Event.swift
//  UFC-FightFinder
//
//  Created by Joseph Garcia on 4/5/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import Foundation
import Alamofire

class Event {
    
    private var _name: String!
    private var _eventId: Int!
    private var _titleDescription: String!
    private var _eventDate: String!
    private var _ticketUrl: String!
    private var _ticketSeller: String!
    private var _eventTitle: String!
    private var _headliner: String!
    private var _ticketSaleDate: String!
    private var _eventImage: String!
    private var _eventProvider: String!
    private var _status: String!
    private var _venue: String!
    private var _location: String!
    
    var name: String {
        return _name
    }
    
    var eventId: Int {
        return _eventId
    }
    
    var titleDescription: String {
        return _titleDescription
    }
    
    var eventDate: String {
        return _eventDate
    }
    
    var ticketUrl: String {
        return _ticketUrl
    }
    
    var ticketSeller: String {
        return _ticketSeller
    }
    
    var eventTitle: String {
        return _eventTitle
    }
    
    var headliner: String {
        return _headliner
    }
    
    var ticketSaleDate: String {
        return _ticketSaleDate
    }
    
    var eventImage: String {
        return _eventImage
    }
    
    var eventProvider: String {
        return _eventProvider
    }
    
    var status: String {
        return _status
    }
    
    var venue: String {
        return _venue
    }
    
    var location: String {
        return _location
    }
    
    init(name: String, eventId: Int, headliner: String , url: String?) {
        self._name = name
        self._eventId = eventId
        self._headliner = headliner
        self._eventImage = url
    }
    
    func grabUfcEvents(completed: DownloadComplete) {
        let url = NSURL(string: UFC_EVENTS_URL)!
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            print(response)
            completed()
        }
    }
    
}