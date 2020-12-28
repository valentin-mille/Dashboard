//
//  WeatherModel.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation

struct WeatherModel: Decodable {
    let weatherInfo: WeatherInfosModel
    let placeName: String
    
    private enum CodingKeys: String, CodingKey {
        case weatherInfo = "main"
        case placeName = "name"
    }
}
