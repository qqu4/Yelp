//
//  DetailRequest.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-07.
//

import Foundation

struct DetailRequest {
    var path: String
    let parameters: Parameters
    
    private init(path: String, parameters: Parameters) {
        self.path = path
        self.parameters = parameters
    }
}

extension DetailRequest {
    static func from(path: String, businessId: String) -> DetailRequest {
        let parameters = ["id": "\(businessId)"]
        return DetailRequest(path: path, parameters: parameters)
    }
}
