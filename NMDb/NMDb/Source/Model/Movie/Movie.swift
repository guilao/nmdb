//
//  Movie.swift
//  NMDb
//
//  Created by Gian Nucci on 31/01/18.
//  Copyright © 2018 nucci. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    var identifier: Int?
    var voteAverage: Double?
    var title: String?
    var originalTitle: String?
    var popularity: Double?
    var posterPath: String?
    var backdropPath: String?
    var overview: String?
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case voteAverage = "vote_average"
        case title
        case originalTitle = "original_title"
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
    }
}
