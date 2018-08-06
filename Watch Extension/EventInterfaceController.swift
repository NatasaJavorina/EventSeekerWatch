//
//  EventInterfaceController.swift
//  Watch Extension
//
//  Created by Natasa Javorina on 14/11/2017.
//  Copyright © 2017 DoomsdayHackers. All rights reserved.
//

import WatchKit
import Foundation
import UIKit
import WatchConnectivity


class EventInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var eventImage: WKInterfaceImage!
    @IBOutlet var eventNameLabel: WKInterfaceLabel!
    @IBOutlet var eventTypeLabel: WKInterfaceLabel!
    @IBOutlet var eventDateLabel: WKInterfaceLabel!
    @IBOutlet var venueNameLabel: WKInterfaceLabel!
    @IBOutlet var venueAddressLabel: WKInterfaceLabel!
    @IBOutlet var interfaceMap: WKInterfaceMap!
    @IBOutlet var mapSlider: WKInterfaceSlider!
    @IBOutlet var attractionsTable: WKInterfaceTable!
    
    @IBOutlet var buyTicket: WKInterfaceButton!
    
    var dateFormatter: DateFormatter?
    var session: WCSession!

    var event: Event! {
        didSet {
            guard let event = event else { return }
            
            eventImage.setImage(event.image)
            eventNameLabel.setText(event.name)
            eventTypeLabel.setText(event.eventType)
            venueNameLabel.setText(event.venueName)
            venueAddressLabel.setText(event.venueAddress)
            let formattedDate = dateFormatter?.string(from: event.dateTime)
            eventDateLabel.setText(formattedDate)
            
            setMapPinWithZoomLevel(level: 1)

            attractionsTable.setNumberOfRows(event.attractions.count, withRowType: "AttractionRow")
            for (index, attraction) in event.attractions.enumerated() {
                guard let controller = attractionsTable.rowController(at: index) as? AttractionRowController else { continue }
                controller.attraction = attraction
            }
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        dateFormatter = DateFormatter()
        dateFormatter?.dateFormat = "MMM d, h:mm a"
        
        if let event = context as? Event {
            self.event = event
            
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if WCSession.isSupported() {
            self.session = WCSession.default
            self.session.delegate = self
            self.session.activate()
        }
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // MARK: - Private methods
    private func setMapPinWithZoomLevel(level: Int) {
        guard let event = self.event else { return }
        let span = MKCoordinateSpanMake(0.1/Double(level), 0.1/Double(level))
        let region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(event.venueLat, event.venueLong), span)
        interfaceMap.setRegion(region)
        interfaceMap.addAnnotation(CLLocationCoordinate2DMake(event.venueLat, event.venueLong), with: .red)
    }
    
    // MARK: - Actions
    @IBAction func changeMapRegion(value: Float) {
        if value == 0 { return }
        setMapPinWithZoomLevel(level: Int(value))
    }
    
    //MARK: - WatchConnectivity
    
    
    func session(_ session: WCSession,
                 didReceiveMessage message: [String : Any],
                 replyHandler: @escaping ([String : Any]) -> Void)
    {
        //this function is mandatory and can be empty
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
        
    }
    
    @IBAction func sendMessage(){
        
        let eventDict = ["url": "\(event.ticketUrl)", "name": "\(event.name)", "image": "\(event.imageUrl)"]
        do {
            try session.sendMessage(eventDict, replyHandler: nil, errorHandler: nil)
        } catch {
            print("error")
        }
        self.buyTicket.setTitle("In Progress...")
        
    }
    

}

