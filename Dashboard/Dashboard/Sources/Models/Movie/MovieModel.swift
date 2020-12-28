//
//  MovieModel.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation

class MovieModel: Decodable {
    let overview: String
    let releaseDate: String?
    let movieTitle: String?
    let serieName: String?
    let originalLanguage: String
    let posterPath: String
    let backdropPath: String
    let mediaType: String
    
    private enum CodingKeys: String, CodingKey {
        case overview = "overview"
        case releaseDate = "release_date"
        case movieTitle = "title"
        case serieName = "name"
        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case mediaType = "media_type"
    }
}
