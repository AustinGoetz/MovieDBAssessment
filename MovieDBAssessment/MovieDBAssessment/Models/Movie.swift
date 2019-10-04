//
//  Movie.swift
//  MovieDBAssessment
//
//  Created by Austin Goetz on 10/4/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable {
    
    let results: [Movies]
    
}

struct Movies: Decodable {
    
    let image: String? //Change with keys
    let title: String
    let overview: String
    let rating: Double //Change with keys
    
    enum CodingKeys: String, CodingKey {
        case image = "poster_path"
        case title
        case overview
        case rating = "vote_average"
    }
}
