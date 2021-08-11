//
//  DetailViewController.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-07.
//

import UIKit

class DetailViewController: UIViewController {
    var info: (id:String,alias:String,name:String)!
    private var viewModel: DetailViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private enum CellIdentifiers {
        static let detail = "detailCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        tableView.isHidden = true
        indicatorView.startAnimating()
        
        navigationItem.title = info.name
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        let request = DetailRequest.from(path:info.alias, businessId: info.id)
        viewModel = DetailViewModel(request: request, delegate: self)
        viewModel.fetchDetails()
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.details?.photos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.detail, for:indexPath) as! DetailTableViewCell
        cell.photo.load(url: (viewModel.details?.photos[indexPath.row])!)
        return cell
    }
}

extension DetailViewController: ViewModelDelegate {
    func onFetchCompleted() {
        indicatorView.stopAnimating()
        
        if let count = viewModel.details?.photos.count, count > 0 {
            tableView.isHidden = false
            tableView.reloadData()
        } else {
            let alert = UIAlertController(title: "Photos unavailable", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func onFetchFailed(with reason: String) {
        indicatorView.stopAnimating()
        let alert = UIAlertController(title: "Warning", message: reason, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
