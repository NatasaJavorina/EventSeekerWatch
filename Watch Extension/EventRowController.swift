//
//  EventRowController.swift
//  Watch Extension
//
//  Created by Bojan Janjic on 11/17/17.
//  Copyright © 2017 DoomsdayHackers. All rights reserved.
//

import WatchKit
import UIKit

class EventRowController: NSObject {
    
    @IBOutlet var eventListImage: WKInterfaceImage!
    @IBOutlet var eventListName: WKInterfaceLabel!
    @IBOutlet var eventListType: WKInterfaceLabel!
    @IBOutlet var eventListDate:WKInterfaceLabel!
    
    let dateFormatter: DateFormatter?
    override init() {
        
        dateFormatter = DateFormatter()
        dateFormatter?.dateFormat = "MMM d, h:mm a"
    }
    
    var event: Event? {
        didSet {
            guard let event = event else {return}

            eventListName.setText(event.name)
            eventListImage.setImage(event.image)
            eventListType.setText(event.eventType)
            let formattedDate = dateFormatter?.string(from: event.dateTime)
            eventListDate.setText(formattedDate)
            
            downloadImage(event: event) {
                self.eventListImage.setImage(event.image)
            }
        }
    }
    
    func downloadImage(event: Event, completion: @escaping ()->()) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let imageData = try Data(contentsOf: URL(string: event.imageUrl)!)
                let image = UIImage(data: imageData)
                event.image = image
            } catch  {
                print("Image download failed")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
