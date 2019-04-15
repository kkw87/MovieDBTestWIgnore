//
//  MovieFetcherTest.swift
//  MovieDBTestTests
//
//  Created by Kevin Wang on 4/15/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import XCTest
@testable import MovieDBTest

class MovieFetcherTest: XCTestCase {

    var sut : MockDataFetcher!
    
    override func setUp() {
        sut = MockDataFetcher()
    }

    override func tearDown() {
        sut = nil
    }

    func testEmptyMovieOnCreation() {
        //given
        sut = MockDataFetcher(errorToAdd: nil)
        
        //when
        var currentMovieCount = 0
        sut.getMovieListOfType(category: .NowPlaying) { (results) in
            switch results {
            case .success(let movies) :
                currentMovieCount = movies.count
            default :
                break
            }
        }
        
        //then
        XCTAssertEqual(currentMovieCount, 0)
    }
    
    func testNilErrorOnCreation() {
        //given
        sut = MockDataFetcher(moviesToAdd: [], errorToAdd: MovieFethcingError.DataError)
        
        //when
        
        //then
        XCTAssertNotNil(sut.currentError)
    }

    func testTwoMoviesAddedOnCallBack() {
        //given
        let movie1 = Movie()
        let movie2 = Movie()
        sut.currentMovies = [movie1, movie2]
        
        //when
        var movieCount = 0
        sut.getMovieListOfType(category: .NowPlaying) { (results) in
            switch results {
            case .success(let movies) :
                movieCount = movies.count
            default :
                break
            }
        }
        
        //then
        XCTAssertEqual(movieCount, 2)
    }
    
    func testErrorReturnedOnCallback() {
        //given
        sut.currentError = MovieFethcingError.DataError
        
        //when
        var returnedError : Error? = nil
        sut.getMovieListOfType(category: .NowPlaying) { (results) in
            switch results {
            case .failure(let error) :
                returnedError = error
            default :
                break
            }
        }
        
        //then
        XCTAssertNotNil(returnedError)
    }

}
