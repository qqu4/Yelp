//
//  BusinessViewModel.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-07.
//

import Foundation

final class BusinessViewModel {
    private weak var delegate: ViewModelDelegate?
    
    var businesses: [Business] = []
    private var isFetchInProgress = false
    
    let client = YelpClient()
    var request: BusinessRequest
    
    init(request: BusinessRequest, delegate: ViewModelDelegate) {
        self.request = request
        self.delegate = delegate
    }
    
    func fetchBusinesses() {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        client.fetchBusinesses(with: request) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.reason)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.businesses = response.businesses
                    self.delegate?.onFetchCompleted()
                }
            }
        }
    }
}
