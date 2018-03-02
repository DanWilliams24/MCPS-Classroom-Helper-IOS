//
//  Course.swift
//  MYPApp
//
//  Created by Daniel on 3/2/18.
//  Copyright © 2018 Daniel Williams. All rights reserved.
//

import Foundation
import JSONJoy

struct Sample: JSONJoy {
    var names = [String]()
    
    init(_ decoder: JSONLoader) throws {
        //name = try decoder[1]["name"].get()
        do {
            var i = 0;
            while (i < (decoder.getOptionalArray()?.count)!) {
                names.append(try decoder[i]["name"].get())
                i += 1;
            }
        }catch{
            print("Unable to parse through JSON array")
            names.append("ERROR")
        }
        
    }
}


