//
//  Event.swift
//  EventSeeker
//
//  Created by Natasa Javorina on 14/11/2017.
//  Copyright © 2017 DoomsdayHackers. All rights reserved.
//

import UIKit

class Event {
    
    //event properties
    let name: String
    let imageUrl: String
    var image: UIImage?
    let dateTime: Date
    var eventType: String = ""
    let detailUrl: String
    let ticketUrl: String
    
    //venue properties
    var venueName: String = ""
    var venueCity: String = ""
    var venueAddress: String = ""
    var venueLat: Double = 0.0
    var venueLong: Double = 0.0
    
    //attractions
    var attractions = [Attraction]()
    
    init(dict: Dictionary<String, Any>) {
        name = dict["name"] as! String
        
        let images = dict["images"] as! [[String:Any]]
        imageUrl = images[9]["url"] as! String
        ticketUrl = dict["url"] as! String
        
        let startDateDict = (dict["dates"] as! [String: Any])["start"] as! [String: Any]
        
        var date = " "
        if let dateTemp = startDateDict["dateTime"] {
            date = dateTemp as! String
        } else {
            date = "2018-09-08T22:15:00Z"
        }
    //comment added
   //     let date = "2018-09-08T22:15:00Z" // startDateDict["dateTime"] as! String
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        
        dateTime = formatter.date(from: date)!
        if let classifications = dict["classifications"] as? [[String: Any]] {
            if let evntTpe = (classifications[0]["segment"] as! [String: String])["name"] {
                eventType = evntTpe
            }
        }
        
        
        detailUrl = ((dict["_links"] as! [String: Any])["self"] as! [String: String])["href"]!
        
        if let embededDict = dict["_embedded"] as? [String: Any] {
            let venueDict = (embededDict["venues"] as! [[String: Any]])[0]
        
          //  venueName = venueDict["name"] as! String
            
            if let venueNameTemp = venueDict["name"]  {
                venueName = venueNameTemp as! String
            } else {
                venueName = ""
            }
            
            
            venueCity = (venueDict["city"] as! [String: String])["name"]!
            venueAddress = (venueDict["address"] as! [String: String])["line1"]!
        


            //fake location
            venueLat = 52.2292
            venueLong = 5.1669
            
            if let attractionDictsArray = embededDict["attractions"] as? [[String: Any]] {
                for dict in attractionDictsArray {
                    attractions.append(Attraction(dict: dict))
                }
            }
        }
    }
    
}

