//
//  MovieListViewModel.swift
//  MovieDBTest
//
//  Created by Kevin Wang on 4/14/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation

class MovieListViewModel {
    
    
    // MARK: - Output
    private(set) var currentMovies : [Movie] = []
    
    var showError : ((Error) -> Void)!
    var moviesDownloaded : (() -> Void)!
    
    // MARK: - Dependency Injection
    private let dataProvider : DataFetching
    private let movieListType : MovieListType
    
    // MARK: - Init
    init(dataProvider : DataFetching, movieListType : MovieListType) {
        self.dataProvider = dataProvider
        self.movieListType = movieListType
    }
    
    // MARK: - Data Fetching
    func viewLoaded() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.dataProvider.getMovieListOfType(category: strongSelf.movieListType, completion: { (results) in
                switch results {
                case .success(let movies) :
                    strongSelf.currentMovies = movies
                    strongSelf.moviesDownloaded()
                case .failure(let error) :
                    strongSelf.showError(error)
                }
            })
        }
    }
    
    
}
