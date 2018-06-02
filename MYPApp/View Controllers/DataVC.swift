//
//  DataVC.swift
//  MYPApp
//
//  Created by Daniel on 3/1/18.
//  Copyright © 2018 Daniel Williams. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON
import Moya
/*
 A reoccuring issue when doing http requests has been the asynchronous processing that takes place in the background. This happens because the app prioritizes actions it can do immediately,while letting time consuming processes take the backseat. To work-around this, a completion handler is added to the end of the request to run once the request done. This completion handler then updates the table view with the updated data.
 */
enum Sender {
    case PRTL
    case MCPS
}

class DataVC: UITableViewController {
    let provider = MoyaProvider<MyService>()
    var classes = [Class]()
    var test = [Class]()
    var courses = [Course]()
    
    @IBOutlet weak var navBarItem: UINavigationItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        test = [Class(name: "MYP 1"),Class(name: "Class 2"),Class(name: "Class 3"),Class(name: "Class 4")]
        getMCPSData()
        self.reloadTable()
        
    }
    
    
    func getPRTLData() /*-> PRTLData*/ {
        var myStruct = PRTLData()
        //var parsedResponse = PRTLData
        provider.request(.PRTL) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                print(statusCode)
                print(data)
                myStruct = self.readJSON(json: JSON(data), sender: .PRTL) as! PRTLData
                ///*
                for course in myStruct.courses {
                    self.classes.append(Class(name: course))
                }
                self.navBarItem.title = myStruct.full_name[1] + "'s Assignments"
                self.reloadTable()
              // */
                self.navBarItem.title = myStruct.full_name[1] + "'s Assignments"
            case .failure(let error):
                print(error)
                myStruct = PRTLData()
                //self.loadBackup()
            }
         
        }
        //return myStruct
    }
    
    
    func getMCPSData() /*-> MCPSData*/ {
        var parsedResponse = MCPSData()
        provider.request(.MCPS) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                print(statusCode)
                parsedResponse = self.readJSON(json: JSON(data), sender: .MCPS) as! MCPSData
                ///*
                for courseItem in parsedResponse.classes {
                   self.classes.append(Class(name: courseItem.course))
                }
                self.reloadTable()
 //*/
            case .failure(let error):
                print(error)
               // self.loadBackup()
            }
        }
        //return parsedResponse
    }
    
    
    func reloadTable() {
        /*
        let mcpsInfo = getMCPSData()
        let prtlInfo = getPRTLData()
        
        let combined = CombinedData(mcps: mcpsInfo, prtl: prtlInfo)
        print(combined.teachers)
        self.classes.append(Class(name: "course.key"))
        for course in combined.classList {
            self.classes.append(Class(name: course.key))
        }
         */
        //getMCPSData()
        //getPRTLData()
        
        tableView.reloadData()
    }
    
    func isDataLoaded() -> Bool{
        return !classes.isEmpty
    }
    
    func loadBackup() {
        print("An error occurred when getting the data: ")
       // self.navBarItem.title = "Assignments"
        classes = test
        //reloadTable()
    }
    
    func readJSON(json: JSON, sender: Sender) -> Any {
        print("Beginning this process")
        //print(json["full_name"])
        switch sender {
        case .MCPS:
            return MCPSData(data: json)
        case .PRTL:
            return PRTLData(data: json)
        }
        
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var course : Class
        course = classes[indexPath.row]
        cell.textLabel?.text = course.name
        return cell
        
    }
    
    
    
    @IBAction func reloadButtonPressed(_ sender: Any) {
        classes.removeAll()
        self.reloadTable()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
