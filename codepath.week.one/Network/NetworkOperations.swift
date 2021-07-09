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
    
    public func getNowPlayingMovies(page: Int,completionsHandler: @escaping (NowPlayingRes) -> Void) {
        let paramaters = [
            "api_key": apiKey,
            "page": String(page)
        ]
        let request = AF.request("\(baseUrl)movie/now_playing",parameters: paramaters)
        request.responseDecodable(of: NowPlayingRes.self,completionHandler:{ (response) in
            guard let nowPlayingResponse = response.value else { return }
            completionsHandler(nowPlayingResponse)
        })
        
 
    }
    
}
