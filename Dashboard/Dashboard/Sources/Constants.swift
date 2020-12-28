//
//  Constants.swift
//  Dashboard
//
//  Created by Valentin Mille on 18/11/2020.
//

import Foundation

struct Constants {
    static let baseApiUrl = "http://localhost:8080/"
    
    struct Color {
        static let secondContainerColor = "Container-1"
        static let firstContainerColor = "Container-2"
        static let fontColor = "Font"
        static let backgroundColor = "Background"
        static let widgetConfViewName = "WidgetConfigurationView"
    }
    
    enum Services: String, CaseIterable {
        case Cinema
        case Covid
        case Github
        case Movie
        case Nasa
        case Trump
        case Weather
    }
    
    enum ServicesModelData {
        case covidFrench(CovidFrenchInfoModel)
        case covidFrenchDepartment(CovidFrenchDepartmentInfoModel)
        case cinema(CinemaModel)
        case movie([MovieModel])
        case nasa(NasaModel)
        case trump(TrumpModel)
        case weather(WeatherModel)
        case github(GithubModel)
    }
    
    enum ServiceRequest {
        case covidFrench(CovidRequest)
        case covidFrenchDepartment(FrenchDepartmentRequest)
        case cinema(CinemaRequest)
        case movie(MovieRequest)
        case nasa(NasaRequest)
        case trump(TrumpRequest)
        case weather(WeatherRequest)
        case github(GithubRequest)
    }
}
