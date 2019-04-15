//
//  Movie.swift
//  MovieDBTest
//
//  Created by Kevin Wang on 4/14/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation

struct MovieResults : Codable {
    let results : [Movie]
}

struct Movie : Codable {
    
    let movieTitle : String
    let imagePostPathURL : String
    let description : String
    let popularity : Double
    let releaseDate : String
    
    enum CodingKeys : String, CodingKey {
        case movieTitle = "title"
        case imagePostPathURL = "poster_path"
        case description = "overview"
        case popularity
        case releaseDate = "release_date"
    }
    
    init(title: String = "", imageURL : String = "", description : String = "", popularity : Double = 0.0, releaseDate: String = "") {
        self.movieTitle = title
        self.imagePostPathURL = imageURL
        self.description = description
        self.popularity = popularity
        self.releaseDate = releaseDate
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movieTitle = try values.decode(String.self, forKey: CodingKeys.movieTitle)
        imagePostPathURL = try values.decode(String.self, forKey: CodingKeys.imagePostPathURL)
        description = try values.decode(String.self, forKey: CodingKeys.description)
        popularity = try values.decode(Double.self, forKey: CodingKeys.popularity)
        releaseDate = try values.decode(String.self, forKey: CodingKeys.releaseDate)
    }
}
