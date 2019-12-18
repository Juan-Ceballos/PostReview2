//
//  PodcastAPIClient.swift
//  Podcast-GetPost
//
//  Created by Juan Ceballos on 12/17/19.
//  Copyright © 2019 Juan Ceballos. All rights reserved.
//

import Foundation

class PodcastAPIClient {
    static func fetchPodcast(completion: @escaping (Result<[Podcast], AppError>) -> ())  {
        let podcastEndpointURL = "https://itunes.apple.com/search?media=podcast&limit=200&term=swift"
        
        guard let url = URL(string: podcastEndpointURL) else    {
            completion(.failure(.badURL(podcastEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) {   (result) in
            switch result   {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                
                do  {
                    let wrapper = try JSONDecoder().decode(PodcastWrapper.self, from: data)
                    completion(.success(wrapper.results))
                }
                catch   {
                    completion(.failure(.decodingError(error)))
                }
            }
    
        }
    } //another function another
    
    static func fetchSearchPodcast(searchText: String, completion: @escaping (Result<[Podcast], AppError>) -> ())    {
        let podcastEndpointURL = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchText)"
        
        guard let url = URL(string: podcastEndpointURL) else    {
            completion(.failure(.badURL(podcastEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result   {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                
                do  {
                    let wrapper = try JSONDecoder().decode(PodcastWrapper.self, from: data)
                    completion(.success(wrapper.results))
                }
                catch   {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
}
