//
//  Profile.swift
//  StartupProfileAPI
//
//  Created by Forrest Filler on 7/20/16.
//  Copyright © 2016 forrestfiller. All rights reserved.
//

import UIKit

class Profile: NSObject {
    var firstname: String?
    var lastname: String?
    var email: String?
    var password: String?
    
    // Function to populate the NSObject from data elments being called in from JSON within the ViewController
    func populate(profileInfo: Dictionary<String, AnyObject>) {
        self.firstname = profileInfo["firstname"] as? String
        self.lastname = profileInfo["lastname"] as? String
        self.email = profileInfo["email"] as? String
        self.password = profileInfo["password"] as? String
        
    }

}
