//
//  Startup.swift
//  StartupProfileAPI
//
//  Created by Forrest Filler on 7/20/16.
//  Copyright © 2016 forrestfiller. All rights reserved.
//

import UIKit

class Startup: NSObject {
    var name: String?
    var city: String?
    var founder: String?
    var shares: Int?
    
    // Function to populate the NSObject from data elments being called in from JSON within the ViewController
    func populate(startupInfo: Dictionary<String, AnyObject>) {
        self.name = startupInfo["name"] as? String
        self.city = startupInfo["city"] as? String
        self.founder = startupInfo["founder"] as? String
        self.shares = startupInfo["shares"] as? Int
        
    }
}
