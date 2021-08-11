//
//  ReviewRequest.swift
//  YelpReviewApp
//
//  Created by Qu, Qi (Chloe) on 2021-08-07.
//

import Foundation

struct DetailRequest {
  var path: String {
    return "search"
  }
  
  let parameters: Parameters
  private init(parameters: Parameters) {
    self.parameters = parameters
  }
}

extension DetailRequest {
  static func from(location: String) -> DetailRequest {
    let defaultParameters = ["limit": "10"]
    let parameters = ["location": "\(location)"].merging(defaultParameters, uniquingKeysWith: +)
    return DetailRequest(parameters: parameters)
  }
}
