//
//  Course.swift
//  MYPApp
//
//  Created by Daniel on 3/9/18.
//  Copyright © 2018 Daniel Williams. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Course {
    var course: String
    var id: Int
    var assignments = [Assignment]()
    
    
    init(data: JSON) {
        self.course = data["course"].string!
        self.id = data["id"].int!
        let N = data["assignments"].array?.count
        var i = 0;
        while i > N! {
            self.assignments.append(Assignment(data: data["assignments"][i]))
            i += 1
        }
        
    }
}
