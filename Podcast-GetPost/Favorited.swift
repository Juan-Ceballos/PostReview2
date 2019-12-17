//
//  Favorited.swift
//  Podcast-GetPost
//
//  Created by Juan Ceballos on 12/17/19.
//  Copyright © 2019 Juan Ceballos. All rights reserved.
//

import Foundation

struct Favorited: Encodable    {
    let trackID: String
    let favoritedBy: String
    let collectionName: String
    let artworkUrl: String
}
