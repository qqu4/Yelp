//
//  Detail.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-08.
//

import Foundation

struct Detail: Decodable {
    let id: String
    let name: String
    let photos: [URL]
}
