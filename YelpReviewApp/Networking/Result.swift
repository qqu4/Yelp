//
//  Result.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-07.
//

import Foundation

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
