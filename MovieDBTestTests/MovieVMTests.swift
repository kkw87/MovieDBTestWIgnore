//
//  MovieVMTests.swift
//  MovieDBTestTests
//
//  Created by Kevin Wang on 4/15/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import XCTest
@testable import MovieDBTest

class MovieVMTests: XCTestCase {
    
    var sut : MovieListViewModel!

    override func setUp() {
        
        let mockDataFetcher = MockDataFetcher(moviesToAdd: [Movie(), Movie()], errorToAdd: nil)
        sut = MovieListViewModel(dataProvider: mockDataFetcher, movieListType: .NowPlaying)
        sut.moviesDownloaded = {
        }
        
        sut.showError = { (_) in
        }
    }

    override func tearDown() {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
