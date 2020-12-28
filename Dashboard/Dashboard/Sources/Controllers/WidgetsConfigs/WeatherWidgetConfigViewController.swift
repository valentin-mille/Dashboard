//
//  WeatherWidgetConfigViewController.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import UIKit

class WeatherWidgetConfigViewController: WidgetConfigViewController {
    private let weatherRequest = WeatherRequest()
    @IBOutlet var placeChoiceView: UIView!
    @IBOutlet var placeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshData = ["Every Minute", "Every Day", "Every"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.placeChoiceView.layer.cornerRadius = self.viewCorderRadius
        self.placeTextField.attributedPlaceholder = NSAttributedString(string: "Enter a place (ex: \"Bordeaux\")", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: Constants.Color.fontColor)!.withAlphaComponent(0.6)])
    }
    
    override func configureWidget() {
        if let unpackedText = self.placeTextField.text {
            self.weatherRequest.requestWeatherInfo(placeName: unpackedText) { (result) in
                switch result {
                    case .success(let weatherModel):
                        print(weatherModel.weatherInfo.temperature)
                        self.delegate?.updateWidget(widget: .weather(weatherModel), selectedService: self.selectedService)
                        self.returnToHomeVC()
                    case .failure(let error):
                        print("[Error] while configuring weather \(error.localizedDescription.debugDescription)")
                }
            }
        }
    }
    
    @IBAction func validateConfigAction(_ sender: UIButton) {
        self.configureWidget()
    }
    

}
