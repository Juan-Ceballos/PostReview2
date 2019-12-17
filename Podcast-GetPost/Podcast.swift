//
//  Podcast.swift
//  Podcast-GetPost
//
//  Created by Juan Ceballos on 12/17/19.
//  Copyright © 2019 Juan Ceballos. All rights reserved.
//

import Foundation

struct PodcastWrapper: Decodable    {
    let results: [Podcast]
}

struct Podcast: Decodable  {
    let trackId: Int
    let artistName: String
    let trackName: String
    let primaryGenreName: String
    let artworkUrl600: String
}
