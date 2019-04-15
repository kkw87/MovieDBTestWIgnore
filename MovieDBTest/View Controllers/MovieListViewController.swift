//
//  MovieListViewController.swift
//  MovieDBTest
//
//  Created by Kevin Wang on 4/14/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import UIKit

class MovieListViewController: UITableViewController {
    
    // MARK: - Constants
    struct Constants {
        static let DefaultTableViewHeight : CGFloat = 200.0
    }
    
    // MARK: - View Model
    var viewModel : MovieListViewModel!
    var featureBuilder : FeatureBuilder!
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        // Do any additional setup after loading the view.
//        tableView.estimatedRowHeight = Constants.DefaultTableViewHeight
//        tableView.rowHeight = UITableView.automaticDimension

        loadData()
    }
    
    
    private func bind() {
        viewModel.showError = { [weak self] error in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                self?.showAlertWith(title: "There was an error!", bodyMessage: error.localizedDescription)
            }
        }
        
        viewModel.moviesDownloaded = { [weak self] in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Data fetching
    private func loadData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        viewModel.viewLoaded()
    }
    
    // MARK: - Tableview Datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewTableViewCell.MovieCellReuseIdentifier, for: indexPath) as! MovieTableViewTableViewCell
        
        let selectedMovie = viewModel.currentMovies[indexPath.row]
        movieCell.setupCellWith(movie: selectedMovie)
        
        return movieCell
    }
    
    // MARK: - Tableview Delege
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
