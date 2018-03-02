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
class DataVC: UIViewController {
    
    override func viewDidLoad() {
        Alamofire.request("http://localhost:3000/grades").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
               //print("JSON: \(json)") // serialized json response
                do {
                    let sample = try Sample(JSONLoader(json))
                    for name in sample.names {
                        print(name)
                    }
                }catch{
                    print("unable to parse the JSON")
                }
                
            }
        
         
        }
        
    }
    
    override func didReceiveMemoryWarning() {
    }
    
    
    
}
