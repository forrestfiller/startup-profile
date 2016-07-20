//
//  StartupViewController.swift
//  StartupProfileAPI
//
//  Created by Forrest Filler on 7/20/16.
//  Copyright © 2016 forrestfiller. All rights reserved.
//

import UIKit
import Alamofire

class StartupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var startupTable: UITableView!
    
    let apiUrl = "https://ff-startup-api.herokuapp.com/api/"
    let apiPath = "startup"
    var startupList = Array<Startup>()
    
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
        return self.startupList.count
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
        let startup = startupList[indexPath.row]
        cell.textLabel?.text = startup.name!
        cell.detailTextLabel?.text = startup.founder! + " - " + startup.city! + " - " + "\(startup.shares!)"
        return cell
    }
    
    func jsonParser(){
        Alamofire.request(.GET, apiUrl+apiPath, parameters: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    if let json = response.result.value as? Dictionary<String, AnyObject> {
                        if let startupJson = json["startups"] as? Array<Dictionary<String, AnyObject>> {
                            var parseCount = 0
                            for startupInfo in startupJson {
                                let startup = Startup()
                                parseCount = parseCount+1
                                NSLog("JSON Parsing Index: \(parseCount)" + "\r\n" + "JSON Data Parsed --> \(startupInfo)" + "\r\n")
                                startup.populate(startupInfo)
                                self.startupList.append(startup)
                            }
                            self.startupTable.reloadData()
                        }
                    }
                    else {
                        NSLog("HTTP Request failed: \(response.result.error)")
                    }
                }
        }
    }
}