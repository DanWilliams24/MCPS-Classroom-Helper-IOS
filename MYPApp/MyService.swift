//
//  MyService.swift
//  MYPApp
//
//  Created by Daniel on 3/25/18.
//  Copyright © 2018 Daniel Williams. All rights reserved.
//
import Moya
import Foundation


enum MyService {
    case PRTL
    case MCPS
    //case updateCredentials(id: Int, passwd: String)
}

extension MyService: TargetType {
    var baseURL: URL { return URL(string: "http://localhost:3000")! }
    var path: String {
        switch self {
        case .PRTL:
                return "/portal"
        case .MCPS:
                return "/mcps/api"
        }
    }
    
    var method : Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    
    var sampleData: Data {
        switch self {
        case .MCPS:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        case .PRTL:
            return "{\"id\": \"000000\", \"full_name\": \"Doe, John George\", \"courses\": {\"Chemistry 101\"}}".utf8Encoded
        }
    }
    
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    
    
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

