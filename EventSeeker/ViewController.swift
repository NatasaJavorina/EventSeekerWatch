//
//  ViewController.swift
//  EventSeeker
//
//  Created by Natasa Javorina on 14/11/2017.
//  Copyright © 2017 DoomsdayHackers. All rights reserved.
//

import UIKit
import CoreLocation
import WatchConnectivity
import SafariServices

class ViewController: UIViewController, WCSessionDelegate {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var eventImage: UIImageView?
    @IBOutlet var eventName: UILabel!
    

    var locationManager: CLLocationManager = CLLocationManager()
    var session: WCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestAlwaysAuthorization()
        
        if(WCSession.isSupported()){
            self.session = WCSession.default
            self.session.delegate = self
            self.session.activate()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

        }
    
    @IBAction func didPressBuyTicket(sender: Any) {
        if let url = URL(string: "\(textLabel.text!)") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func downloadImageFromUrl(imageUrl: String, completion: @escaping (_ success: UIImage) -> Void) {
        
        let url = URL(string: imageUrl)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            completion(UIImage(data: data)!)
            
        }
        task.resume()
    }
    
    //    MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let msg = message as? [String: Any] {
            DispatchQueue.main.async {
                self.textLabel.text = msg["url"] as! String
                self.eventName.text = msg["name"] as! String
                self.downloadImageFromUrl(imageUrl: msg["image"] as! String , completion: { image in
                    
                    self.eventImage!.image = image
                    
                })
                
            }
        }
        
        
    }


}

