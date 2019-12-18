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
    
    static func postToFavorite(favorited: Favorited, completion: @escaping (Result<Bool, AppError>) -> ()) {
        let favoriteEndpointURL = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: favoriteEndpointURL)
            else    {
                completion(.failure(.badURL(favoriteEndpointURL)))
                return
        }
        
        do  {
            let data = try JSONEncoder().encode(favorited)
            
            var urlRequest = URLRequest(url: url)
            
            urlRequest.httpMethod = "POST"
            
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            urlRequest.httpBody = data
            
            NetworkHelper.shared.performDataTask(with: urlRequest) { (result) in
                switch result   {
                case .failure(let appError):
                    completion(.failure(appError))
                case .success:
                    completion(.success(true))
                }
            }
            
        }
            
        catch {
            completion(.failure(.encodingError(error)))
        }
        
    }
    
}
