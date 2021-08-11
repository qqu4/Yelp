//
//  ViewModelDelegate.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-07.
//

import Foundation

protocol ViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}
