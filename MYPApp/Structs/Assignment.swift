//
//  Assignment.swift
//  MYPApp
//
//  Created by Daniel on 3/9/18.
//  Copyright © 2018 Daniel Williams. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Assignment {
    var name: String
    var id: Int
    var due_at: String
    
    
    init(data: JSON) {
        self.name = data[0]["name"].string!
        self.id = data[0]["id"].int!
        self.due_at = data[0]["due_at"].string!
    }
}
