//
//  WeatherInfosModel.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation

struct WeatherInfosModel: Decodable {
    let temperature: Double
    let feelsLike: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let pressure: Double
    let humidity: Int

    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}
