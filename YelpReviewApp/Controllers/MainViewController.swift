//
//  MainViewController.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-06.
//

import UIKit

class MainViewController: UIViewController {
    private enum CellIdentifiers {
        static let business = "businessCell"
    }
    private enum SegueIdentifiers {
        static let toDetail = "ToDetail"
    }
    private var viewModel: BusinessViewModel!
    private let defaultLocation = "Toronto"
    private var location: String?
    private let limit = 10
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var sortMode: YelpSortMode = .best_match
    let sortModes:[YelpSortMode] = [.best_match, .rating, .review_count, .distance]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search..."
        location = defaultLocation
                
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortTapped))
        
        startFetchingBusinesses()
    }
    
    @objc func sortTapped(_ sender: UIBarButtonItem) {
        let selectedIndex = sortModes.firstIndex(of: sortMode)!
        let sortViewPopup = SortViewController(selectedIndex: selectedIndex, delegate: self)
        present(sortViewPopup, animated: true, completion: nil)
    }
    
    func startFetchingBusinesses() {
        tableView.isHidden = true
        indicatorView.startAnimating()
        
        let request = BusinessRequest.from(location: location ?? defaultLocation, sortMode: sortMode.rawValue, limit: limit)
        if viewModel == nil {
            viewModel = BusinessViewModel(request: request, delegate: self)
        } else {
            viewModel.request = request
        }
        viewModel.fetchBusinesses()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.toDetail {
            if let detailViewController = segue.destination as? DetailViewController {
                let indexPath = sender as! IndexPath
                detailViewController.info = (viewModel.businesses[indexPath.row].id,viewModel.businesses[indexPath.row].alias,viewModel.businesses[indexPath.row].name)
            }
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: SegueIdentifiers.toDetail, sender: indexPath)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.business, for:indexPath) as! MainTableViewCell
        cell.configure(with: viewModel.businesses[indexPath.row])
        return cell
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchLocation = searchBar.text
        if searchLocation != nil {
            location = searchLocation!
            startFetchingBusinesses()
        }
        searchController.isActive = false
        searchBar.text = searchLocation
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        location = defaultLocation
        startFetchingBusinesses()
    }
}

extension MainViewController: ViewModelDelegate {
    func onFetchCompleted() {
        indicatorView.stopAnimating()
        
        if viewModel.businesses.count > 0 {
            tableView.isHidden = false
            tableView.reloadData()
        } else {
            let alert = UIAlertController(title: "No restaurants available", message: "", preferredStyle: .alert)
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

extension MainViewController: SortViewDelegate {
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        sortMode = sortModes[sender.selectedSegmentIndex]
        startFetchingBusinesses()
    }
}
