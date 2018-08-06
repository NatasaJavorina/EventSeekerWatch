//
//  AttractionRowController.swift
//  Watch Extension
//
//  Created by Natasa Javorina on 19/11/2017.
//  Copyright © 2017 DoomsdayHackers. All rights reserved.
//

import WatchKit

class AttractionRowController: NSObject {
    
    @IBOutlet var attractionNameLabel: WKInterfaceLabel!
    @IBOutlet var attractionImage: WKInterfaceImage!
    
    var attraction: Attraction? {
        didSet {
            guard let attraction = attraction else {return}
            
            attractionNameLabel.setText(attraction.name)
            attractionImage.setImage(attraction.image)
            downloadAttractionImage(attraction: attraction) {
                self.attractionImage.setImage(attraction.image)
            }
        }
    }
    
    func downloadAttractionImage(attraction: Attraction, completion: @escaping ()->()) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let imageData = try Data(contentsOf: URL(string: attraction.imageUrl)!)
                let image = UIImage(data: imageData)
                attraction.image = image
            } catch  {
                print("Image download failed")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    
}
