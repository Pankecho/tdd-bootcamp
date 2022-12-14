//
//  Endpoint.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import Foundation

enum Endpoint {
    static let baseURL = "https://wizetwitterproxy.herokuapp.com"
    
    case timeline
    case search(String)
}

extension Endpoint {
    var string: String {
        switch self {
        case .timeline:
            return "/api/statuses/user_timeline"
        case .search(_):
            return "/api/search/"
        }
    }
    
    var request: URLRequest {
        switch self {
        case .timeline:
            let url = URL(string: Endpoint.baseURL + string)!
            return URLRequest(url: url)
        case .search(let value):
            let url = URL(string: Endpoint.baseURL + string + value)!
            return URLRequest(url: url)
        }
    }
}
