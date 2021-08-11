//
//  BusinessRequest.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-07.
//

import Foundation

struct BusinessRequest {
    var path = "search"
    let parameters: Parameters
    
    private init(parameters: Parameters) {
        self.parameters = parameters
    }
}

extension BusinessRequest {
    static func from(location: String, sortMode: String, limit: Int) -> BusinessRequest {
        let parameters = ["location": location, "sort_by": sortMode, "limit": "\(limit)"]
        return BusinessRequest(parameters: parameters)
    }
}
