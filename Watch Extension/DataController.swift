//
//  DataController.swift
//  Watch Extension
//
//  Created by Natasa Javorina on 20/11/2017.
//  Copyright © 2017 DoomsdayHackers. All rights reserved.
//

import Foundation
import CoreLocation


class DataController {
    
    static let apiKey = "Rkzl2JqJrWHcJ0hgusSmnXUhG2tAPJA2"
    static let baseURL = "https://app.ticketmaster.com/discovery/v2/"
    
    class func getEvents(location: CLLocationCoordinate2D, radius: Int, success: @escaping ([Event])->(), failure: @escaping (NSError)->()) {
        
        let geohash = Geohash.encode(latitude: location.latitude, longitude: location.longitude, precision: .nineteenMeters)
        let url = URL(string: "events.json?apikey=\(apiKey)&geoPoint=\(geohash)&radius=\(radius)", relativeTo: URL(string: baseURL))!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error == nil {
                do {
                    //let str = String.init(data: data!, encoding: String.Encoding.utf8)
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                    let eventsDict = (jsonObject["_embedded"] as! [String: Any])["events"] as! [[String: Any]]
                    
                    var events = [Event]()
                    eventsDict.forEach({ (dict: [String: Any]) in
                        events.append(Event(dict: dict))
                    })
                    
                    DispatchQueue.main.async {
                        success(events)
                    }
                } catch let error as NSError {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    failure(error! as NSError)
                }
            }
        }
        task.resume()
    }
    
}
