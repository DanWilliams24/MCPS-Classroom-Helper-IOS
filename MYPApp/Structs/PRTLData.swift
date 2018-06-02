//
//  PRTLData.swift
//  MYPApp
//
//  Created by Daniel on 3/25/18.
//  Copyright © 2018 Daniel Williams. All rights reserved.
//

import Foundation
import SwiftyJSON
struct PRTLData {
    var id: Int
    var full_name: [String]
    var courses: [String]
    
    
    init(data: JSON) {
        self.id = data["id"].int!
        self.full_name = data["full_name"].string!.replacingOccurrences(of: ",", with: "").components(separatedBy: " ")
        self.courses = data["courses"].arrayObject as! [String]
    }
    
    init() {
        self.id = 0
        self.full_name = [String]()
        self.courses = [String]()
    }
}
