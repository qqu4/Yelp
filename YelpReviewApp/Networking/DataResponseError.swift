//
//  DataResponseError.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-07.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data"
        case .decoding:
            return "An error occurred while decoding data"
        }
    }
}
