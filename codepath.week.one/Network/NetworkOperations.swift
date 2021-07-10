//
//  NetworkOperations.swift
//  codepath.week.one
//
//  Created by Michael on 09/07/2021.
//

import Foundation
import Alamofire

let posterBaseUrl = "https://image.tmdb.org/t/p/w154"

class NetworkOperations {
    
    private let baseUrl: String = "https://api.themoviedb.org/3/"
    private let apiKey: String
    
    init() {
        apiKey = Utilities().getApiKey()
    }
    
    public func getNowPlayingMovies(page: Int,completionsHandler: @escaping (MoviesRes) -> Void) {
        let paramaters = [
            "api_key": apiKey,
            "page": String(page)
        ]
        let request = AF.request("\(baseUrl)movie/now_playing",parameters: paramaters)
        request.responseDecodable(of: MoviesRes.self,completionHandler:{ (response) in
            guard let nowPlayingResponse = response.value else { return }
            completionsHandler(nowPlayingResponse)
        })
    }
    
    public func getTopRatedMovies(page: Int,completionsHandler: @escaping (MoviesRes) -> Void) {
        let paramaters = [
            "api_key": apiKey,
            "page": String(page)
        ]
        let request = AF.request("\(baseUrl)movie/top_rated",parameters: paramaters)
        request.responseDecodable(of: MoviesRes.self,completionHandler:{ (response) in
            guard let nowPlayingResponse = response.value else { return }
            completionsHandler(nowPlayingResponse)
        })
    }
    
    public func search(page: Int,query: String,completionsHandler: @escaping (MoviesRes) -> Void) {
        let paramaters = [
            "api_key": apiKey,
            "page": String(page),
            "query": query
        ]
        let request = AF.request("\(baseUrl)search/movie",parameters: paramaters)
        request.responseDecodable(of: MoviesRes.self,completionHandler:{ (response) in
            guard let nowPlayingResponse = response.value else { return }
            completionsHandler(nowPlayingResponse)
        })
    }
    
    public func getMovieDetails(movieId: Int,completionsHandler: @escaping (MovieDetailsRes) -> Void) {
        let parmaters = [
            "api_key": apiKey,
            "append_to_response": "trailers,reviews"
        ]
        let request = AF.request("\(baseUrl)/movie/\(String(movieId))",parameters: parmaters)
        request.responseDecodable(of: MovieDetailsRes.self,completionHandler: {(response) in
            guard let movieDetailsRes = response.value else {return}
            completionsHandler(movieDetailsRes)
        })
    }
}
