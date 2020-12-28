//
//  CinemaModel.swift
//  Dashboard
//
//  Created by Remi Poulenard on 28/11/2020.
//

import Foundation

struct CinemaModel: Decodable {
    let title: String
    let year: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let actors: String
    let awards: String
    let imdbRating: Float
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case awards = "Awards"
        case imdbRating = "imdbRating"
    }
}
