//
//  YelpClient.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-07.
//

import Foundation

enum YelpSortMode: String {
    case best_match, rating, review_count, distance
}

final class YelpClient {
    let baseURL = URL(string: "https://api.yelp.com/v3/businesses/")!
    let authorizationKey = "Bearer gtWr0os8ppF0unQeO3EcUJQNOgNSZ_rQKa6N6lnEfg6lI2OkJZGaE0yWviOY_QsLV1Z6K4wovatrLJxqSIaSeoH6upGa2jipxmaynAWesff2T2g6gtZygLYkypkMYXYx"
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchBusinesses(with request: BusinessRequest, completion: @escaping (Result<BusinessResponse, DataResponseError>) -> Void) {
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        var encodedURLRequest = urlRequest.encode(with: request.parameters)
        encodedURLRequest.addValue(authorizationKey, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode, let data = data else {
                completion(Result.failure(DataResponseError.network))
                return
            }
            guard let decodedResponse = try? JSONDecoder().decode(BusinessResponse.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
    func fetchDetails(with request: DetailRequest, completion: @escaping (Result<Detail, DataResponseError>) -> Void) {
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        var encodedURLRequest = urlRequest.encode(with: request.parameters)
        encodedURLRequest.addValue(authorizationKey, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode, let data = data else {
                completion(Result.failure(DataResponseError.network))
                return
            }
            guard let decodedResponse = try? JSONDecoder().decode(Detail.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
}
