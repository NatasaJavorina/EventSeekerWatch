//
//  EventListInterfaceController.swift
//  Watch Extension
//
//  Created by Bojan Janjic on 11/17/17.
//  Copyright © 2017 DoomsdayHackers. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation

class EventListInterfaceController: WKInterfaceController, CLLocationManagerDelegate {
    
    @IBOutlet var eventListTable: WKInterfaceTable!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var events = [Event]()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestLocation()
       
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let event = events[rowIndex]
        presentController(withName: "Event", context: event)
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DataController.getEvents(location: location.coordinate, radius: 10, success: { (events) in
            
            self.events = events
            
            self.eventListTable.setNumberOfRows(self.events.count, withRowType: "EventRow")
            for index in 0..<self.eventListTable.numberOfRows {
                guard let controller = self.eventListTable.rowController(at: index) as? EventRowController else { continue }
                let event = self.events[index]
                controller.event = event
            }
            
        }) { error in
            print(error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error as NSError)
    }
}







