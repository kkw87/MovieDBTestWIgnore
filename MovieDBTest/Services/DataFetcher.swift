//
//  DataFetcher.swift
//  MovieDBTest
//
//  Created by Kevin Wang on 4/14/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation

enum MovieListType : String {
    
    case NowPlaying = "/movie/now_playing"
    case Popular = "/movie/popular"
    case TopRated = "/movie/top_rated"
    case Upcoming = "/movie/upcoming"
    
}

enum MovieFethcingError : Error, CustomStringConvertible {
    case ServerError
    case DataError
    
    var description: String {
        switch self {
        case .ServerError:
            return "There was an error communicating with the server"
        default:
            return "There was an error"
        }
    }
}

final class DataFetcher : DataFetching {
    
    struct Constants {
        static let BaseURL = URL(string: "https://api.themoviedb.org/3")!
    }
    
    
    
    func getMovieListOfType(category: MovieListType, completion: @escaping (Result<[Movie], Error>) -> Void) {
        buildRequest(pathComponent: category.rawValue) { (results) in
            switch results {
            case.success(let data) :
                let jsdonDecoder = JSONDecoder()
                do {
                    let movieResults = try jsdonDecoder.decode(MovieResults.self, from: data)
                    completion(.success(movieResults.results))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func buildRequest(method : String = "GET", pathComponent : String, params: [(String, String)] = [], completionHandler : @escaping (Result<Data, Error>) -> Void) {
        
        let url = Constants.BaseURL.appendingPathComponent(pathComponent)
        var request = URLRequest(url: url)
        let keyQueryItem = URLQueryItem(name: "api_key", value: MovieDataBaseKeys.APIKey)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        var queryItems = params.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        
        queryItems.append(keyQueryItem)
        urlComponents.queryItems = queryItems
        request.url = urlComponents.url
        request.httpMethod = method
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let serverResponse = response as? HTTPURLResponse, 200...300 ~= serverResponse.statusCode else {
                completionHandler(.failure(MovieFethcingError.ServerError))
                return
            }
            
            guard error == nil else {
                completionHandler(.failure(error!))
                return
            }
            
            guard let downloadedData = data else {
                completionHandler(.failure(MovieFethcingError.DataError))
                return
            }
            
            completionHandler(.success(downloadedData))
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
        
    }
    
    
}
