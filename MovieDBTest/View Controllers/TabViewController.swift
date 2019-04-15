//
//  TabViewController.swift
//  MovieDBTest
//
//  Created by Kevin Wang on 4/14/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    // MARK: - Dependency Injection
    var featureBuilder : FeatureBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nowPlayingVC = featureBuilder.buildMovieListController(withMovieType: .NowPlaying, andTag: 0)
        let popularVC = featureBuilder.buildMovieListController(withMovieType: .Popular, andTag: 1)
        let topRatedVC = featureBuilder.buildMovieListController(withMovieType: .TopRated, andTag: 2)
        let upcomingVC = featureBuilder.buildMovieListController(withMovieType: .Upcoming, andTag: 3)
        
        self.viewControllers = [nowPlayingVC, popularVC, topRatedVC, upcomingVC]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
