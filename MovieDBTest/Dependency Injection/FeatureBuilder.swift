//
//  FeatureBuilder.swift
//  MovieDBTest
//
//  Created by Kevin Wang on 4/14/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import UIKit

final class FeatureBuilder {
    
    func buildTabRootViewController() -> UIViewController {
        
        guard let currentTabVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController() as? TabViewController else {
            fatalError("Unable to instantiate Root Tab Bar VC ")
        }
        
        currentTabVC.featureBuilder = FeatureBuilder()
        
        return currentTabVC
    }
    
    func buildMovieListController(withMovieType : MovieListType, andTag tag : Int) -> UIViewController {
        
        guard let navigationVC = UIStoryboard.init(name: "MovieList", bundle: nil).instantiateInitialViewController() as? UINavigationController, let movieVC = navigationVC.viewControllers[0] as? MovieListViewController else {
            fatalError("Unable to instantiate movie VC")
        }
        
        let movieVM = MovieListViewModel(dataProvider: DataFetcher(), movieListType: withMovieType)
            movieVC.viewModel = movieVM
            movieVC.featureBuilder = FeatureBuilder()
        
        let tabIconName : String
        switch withMovieType {
        case .NowPlaying :
            tabIconName = "Now Playing"
        case .Popular :
            tabIconName = "Popular"
        case .TopRated :
            tabIconName = "Top Rated"
        case .Upcoming :
            tabIconName = "Upcoming"
            
        }

        navigationVC.tabBarItem = UITabBarItem(title: tabIconName, image: nil, tag: tag)
        movieVC.navigationItem.title = tabIconName
        return navigationVC
    }
    
}
