//
//  MockDataFetcher.swift
//  MovieDBTest
//
//  Created by Kevin Wang on 4/15/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation

class MockDataFetcher : DataFetching {
    
    var currentMovies : [Movie] = []
    var currentError : Error?
    
    init(moviesToAdd : [Movie] = [], errorToAdd : Error? = nil) {
        currentMovies = moviesToAdd
        currentError = errorToAdd
    }
    
    func getMovieListOfType(category: MovieListType, completion: @escaping (Result<[Movie], Error>) -> Void) {
        if currentError != nil {
            completion(.failure(currentError!))
        } else {
            completion(.success(currentMovies))
        }
    }
    
    
    
    
}
