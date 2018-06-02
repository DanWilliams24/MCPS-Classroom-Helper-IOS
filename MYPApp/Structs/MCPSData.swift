//
//  MCPSData.swift
//  MYPApp
//
//  Created by Daniel on 3/25/18.
//  Copyright © 2018 Daniel Williams. All rights reserved.
//

import Foundation
import SwiftyJSON
/*
 Due to the complexity of the JSON response returned from the corresponding API call, this
 struct offers a flat representation of this JSON. This means that Subarrays and subjsons are not represented by "has a" and "is a" relationships and instead are represented based on their position in the array. For Example:
 
        The JSON
 [{ course: "", topic: "", data: [{Student: "", id: 0}] }]
 
 is represented by an array of courses,topics,Students and ids.
 
 Courses - Chemistry , Math, English
 Topics - Thermochemistry , Derivatives , Poetry
 Students - [Tom,Ann,Roger], [Dan, Amy, Mike], [April, Carol, Jeff]
 Ids - [103,354,432] , [23,4,65] , [232,435,464]
 
 
 This is only a temporary solution and should be fixed using a object oriented model for code reuse purposes.
*/
struct MCPSData {
    var classes = [Course]()
    
    init() {
        
    }
    
    init(data: JSON) {
        let N = data["classes"].array?.count
        var i = 0
        while i < N! {
            print(data["classes"][i])
            self.classes.append(Course(data: data["classes"][i]))
            i += 1
        }
    }
}
