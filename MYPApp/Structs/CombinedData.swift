//
//  CombinedData.swift
//  MYPApp
//
//  Created by Daniel on 4/1/18.
//  Copyright © 2018 Daniel Williams. All rights reserved.
//

import Foundation


struct CombinedData {
    var classList: [String:Course]
    var teachers: [String]
    
    init(mcps: MCPSData, prtl: PRTLData) {
        let mList = mcps.classes
        let pList = prtl.courses
        print("Jellewf")
        self.teachers = [String]()
        self.classList = [String:Course]()
        for pCourse in pList {
            print(pCourse)
        }
        self.teachers.append("Unknown")
        for pCourse in pList {
            var noData = true
            for mCourse in mList {
                let details = mCourse.course.split(separator: ":")
                var courseName = ""
                if(details[0].contains("[PC_e]")){
                    courseName = details[0].replacingOccurrences(of: "[PC_e]", with: "")
                }else{
                    courseName += details[0]
                }
                if(pCourse.elementsEqual(courseName)){
                    self.teachers.append(details[1]+"")
                    self.classList[pCourse] = mCourse
                    noData = false
                }
                print(courseName)
            }
            if(noData){
                self.teachers.append("Unknown")
                self.classList[pCourse] = nil
            }
        }
    }
}
