//
//  WeatherWidgetCollectionViewCell.swift
//  Dashboard
//
//  Created by Valentin Mille on 15/12/2020.
//

import UIKit

class WeatherWidgetCollectionViewCell: WidgetCollectionViewCell {
    @IBOutlet var weatherLabel: UILabel!
    static let widgetIdentifier = "WeatherWidgetCell"
    private let weatherRequest = WeatherRequest()
    private var placeName: String = ""

    static func widgetNib() -> UINib {
        return UINib(nibName: "WeatherWidgetCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func configureWidget(serviceModel: Constants.ServicesModelData) {
        switch serviceModel {
            case .weather(let weatherModel):
                self.updateWeather(weatherModel: weatherModel)
            default:
                break
        }
    }
    
    func updateWeather(weatherModel: WeatherModel) {
        self.placeName = weatherModel.placeName
        let message = "Place 🏙: \(weatherModel.placeName)\nTemperature 🌡:  \(weatherModel.weatherInfo.temperature)\n"
        weatherLabel.text = message
    }
    
    @IBAction override func refreshWidget(_ sender: UIButton) {
        self.weatherRequest.requestWeatherInfo(placeName: self.placeName) { (response) in
            switch response {
                case .success(let weatherModel):
                    self.updateWeather(weatherModel: weatherModel)
                case .failure(let error):
                    print("[Error] during weather refresh widget data \(error.localizedDescription.debugDescription)")
            }
        }
    }
    
}
