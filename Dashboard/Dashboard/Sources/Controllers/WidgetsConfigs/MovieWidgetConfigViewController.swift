//
//  CinemaWidgetViewController.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import UIKit

class MovieWidgetConfigViewController: WidgetConfigViewController {
    private let requestMovie = MovieRequest()
    @IBOutlet var movieConfigPicker: UIPickerView!
    @IBOutlet var movieChoiceView: UIView!
    
    let pickerData = [["movie", "tv"], ["day", "week"]]
    private let refreshTimeList = ["Every day", "Every week", "Every Month"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieConfigPicker.delegate = self
        self.movieConfigPicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.movieChoiceView.layer.cornerRadius = self.viewCorderRadius
    }
    
    override func configureWidget() {
        let mediaType = self.pickerData[0][self.movieConfigPicker.selectedRow(inComponent: 0)]
        let windowTime = self.pickerData[1][self.movieConfigPicker.selectedRow(inComponent: 1)]
        
        self.requestMovie.requestMovieTrend(mediaType: mediaType, windowTime: windowTime) { (result) in
            switch result {
                case .success(let movieModelList):
                    print(movieModelList[0].movieTitle ?? "nil")
                    self.delegate?.updateWidget(widget: .movie(movieModelList), selectedService: self.selectedService)
                    self.returnToHomeVC()
                case .failure(let error):
                    print("[Error] while configuring movie \(error.localizedDescription.debugDescription)")
            }
        }
    }

    @IBAction func validateConfigAction(_ sender: UIButton) {
        self.configureWidget()
    }

}

//MARK: - PickerViewDelegate, PickerViewDatasource

extension MovieWidgetConfigViewController {
    override func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1 {
            return 1
        }
        return self.pickerData.count
    }
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return self.refreshTimeList.count
        }
        return self.pickerData[component].count
    }
    
    override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return self.refreshTimeList[row]
        }
        return self.pickerData[component][row]
    }
    
    override func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView.tag == 1 {
            return NSAttributedString(string: self.refreshTimeList[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: Constants.Color.fontColor)!])
        }
        return NSAttributedString(string: self.pickerData[component][row], attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: Constants.Color.fontColor)!])
    }
}
