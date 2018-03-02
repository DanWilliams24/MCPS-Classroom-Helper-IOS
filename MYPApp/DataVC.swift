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
import JSONJoy
/*
 A reoccuring issue when doing http requests has been the asynchronous processing that takes place in the background. This happens because the app prioritizes actions it can do immediately,while letting time consuming processes take the backseat. To work-around this, a completion handler is added to the end of the request to run once the request done. This completion handler then updates the table view with the updated data.
 */

class DataVC: UITableViewController {
    var classes = [Course]()
    var test = [Course]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test = [Course(name: "1"),Course(name: "2"),Course(name: "3"),Course(name: "4")]
        let req = Alamofire.request("http://localhost:3000/grades").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                do {
                    let sample = try Sample(JSONLoader(json))
                    for course in sample.names {
                        self.classes.append(Course(name: course))
                        //print(self.classes[0])
                    }
                }catch{
                    print("unable to parse the JSON")
                    
                }
            }
            return
        }.response(completionHandler: {(response) in
            self.tableView.reloadData()
        })
        req.resume()
        
        
        
    }
    
    func dataHasLoaded() {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var course : Course
        course = classes[indexPath.row]
        cell.textLabel?.text = course.name
        return cell
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
