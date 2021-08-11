//
//  Business.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-07.
//

import Foundation

struct BusinessResponse: Decodable {
    let businesses: [Business]
}

struct Business: Decodable {
    let id: String
    let alias: String
    let name: String
    let image_url: String
    let review_count: Int
    let rating: Double
    let price: String?
}
