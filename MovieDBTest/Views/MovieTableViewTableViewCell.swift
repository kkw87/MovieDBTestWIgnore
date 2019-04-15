//
//  MovieTableViewTableViewCell.swift
//  MovieDBTest
//
//  Created by Kevin Wang on 4/14/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import UIKit

class MovieTableViewTableViewCell: UITableViewCell {

    // MARK: - Constants
    static let MovieCellReuseIdentifier = "Movie Cell"
    
    struct Constants {
        static let PosterBaseURL = "http://image.tmdb.org/t/p/w185/"
    }

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var movieImageDisplay: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! 
    
    // MARK: - Instance Variables
    
    private var movieImage : UIImage? {
        get {
            return movieImageDisplay.image
        } set {
            movieImageDisplay.image = newValue
            activityIndicator.stopAnimating()
        }
    }
    
    private var movieTitle : String? {
        get {
            return titleLabel.text
        } set {
            titleLabel.text = newValue
        }
    }
    
    private var movieDescription : String? {
        get {
            return bodyLabel.text
        } set {
            bodyLabel.text = newValue
        }
    }
    
    // MARK: - Setup
    func setupCellWith(movie : Movie) {
        
        movieTitle = movie.movieTitle
        movieDescription = movie.description
        
        fetchMovieImageWith(path: movie.imagePostPathURL)
        
    }

    
    // MARK: - Preprae for reuse
    override func prepareForReuse() {
        movieImage = nil
        movieTitle = ""
        movieDescription = ""
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Network functions
    
    private func fetchMovieImageWith(path : String) {
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
        guard let downloadURL = URL(string: "\(Constants.PosterBaseURL)\(path)") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: downloadURL) {[weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                guard let imageData = data, let downloadedImage = UIImage(data: imageData) else {
                    return
                }
                self?.movieImage = downloadedImage
            }
            
            
            
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            dataTask.resume()
        }
        
        
    }
    

}
