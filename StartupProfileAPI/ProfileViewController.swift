//
//  ProfileViewController.swift
//  StartupProfileAPI
//
//  Created by Forrest Filler on 7/20/16.
//  Copyright © 2016 forrestfiller. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var profileTable: UITableView!
    
    let apiUrl = "https://ff-startup-api.herokuapp.com/api/"
    let apiPath = "profile"
    var profileList = Array<Profile>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jsonParser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View and Cell Setup
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profileList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "cellId"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId) {
            return self.ConfigureCell(cell, indexPath: indexPath)
        }
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        return self.ConfigureCell(cell, indexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
    }
    
    func ConfigureCell(cell:UITableViewCell, indexPath:NSIndexPath) -> UITableViewCell {
        let profile = profileList[indexPath.row]
        cell.textLabel?.text = profile.firstname! + " " + profile.lastname!
        cell.detailTextLabel?.text = "Email: " + profile.email! + " Password: " + profile.password!
        return cell
    }
    
        func jsonParser(){
            Alamofire.request(.GET, apiUrl+apiPath, parameters: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    if (response.result.error == nil) {
                        if let json = response.result.value as? Dictionary<String, AnyObject> {
                            if let profileJson = json["profiles"] as? Array<Dictionary<String, AnyObject>> {
                                var parseCount = 0
                                for profileInfo in profileJson {
                                    let profile = Profile()
                                    parseCount = parseCount+1
                                    NSLog("JSON Parsing Index: \(parseCount)" + "\r\n" + "JSON Data Parsed --> \(profileInfo)" + "\r\n")
                                    profile.populate(profileInfo)
                                    self.profileList.append(profile)
                                }
                                self.profileTable.reloadData()
                            }
                        }
                        else {
                            NSLog("HTTP Request failed: \(response.result.error)")
                        }
                    }
            }
        }
}