//
//  DetailViewModel.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-08.
//

import Foundation

final class DetailViewModel {
    private weak var delegate: ViewModelDelegate?
    
    var details: Detail?
    private var isFetchInProgress = false
    
    let client = YelpClient()
    let request: DetailRequest
    
    init(request: DetailRequest, delegate: ViewModelDelegate) {
        self.request = request
        self.delegate = delegate
    }
    
    func fetchDetails() {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        client.fetchDetails(with: request) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.reason)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.details = response
                    self.delegate?.onFetchCompleted()
                }
            }
        }
    }
}
