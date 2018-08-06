//
//  Attraction.swift
//  EventSeeker
//
//  Created by Natasa Javorina on 14/11/2017.
//  Copyright © 2017 DoomsdayHackers. All rights reserved.
//

import Foundation
import UIKit

class Attraction {
    
    let name: String
    let imageUrl: String
    var image: UIImage?
    
    init(dict: Dictionary<String, Any>) {
        name = dict["name"] as! String
        let images = dict["images"] as! [[String:Any]]
        imageUrl = images[9]["url"] as! String
    }
}
