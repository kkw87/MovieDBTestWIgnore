//
//  DataFetching.swift
//  MovieDBTest
//
//  Created by Kevin Wang on 4/14/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation

protocol DataFetching {
    
    func getMovieListOfType(category : MovieListType, completion : @escaping (Result<[Movie], Error>) -> Void)
    
}
