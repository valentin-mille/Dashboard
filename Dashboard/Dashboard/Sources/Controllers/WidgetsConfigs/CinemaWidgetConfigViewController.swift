//
//  CinemaWidgetConfigViewController.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import UIKit

class CinemaWidgetConfigViewController: WidgetConfigViewController {
    @IBOutlet var movieTitleTextField: UITextField!
    private let cinemaRequests = CinemaRequest()
    @IBOutlet var movieChoiceView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.deactivateRefreshView()
        self.movieChoiceView.layer.cornerRadius = self.viewCorderRadius
        self.movieTitleTextField.attributedPlaceholder = NSAttributedString(string: "Enter a movie title (ex: \"tenet\")", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: Constants.Color.fontColor)!.withAlphaComponent(0.6)])
    }
    
    override func configureWidget() {
        if let unpackedTitle = self.movieTitleTextField.text {
            self.cinemaRequests.requestCinemaInformations(movieTitle: unpackedTitle) { (result) in
                switch result {
                    case .success(let cinemaModel):
                        print(cinemaModel.title)
                        self.delegate?.updateWidget(widget: .cinema(cinemaModel), selectedService: self.selectedService)
                        self.returnToHomeVC()
                    case .failure(let error):
                        print("[Error] while configuring cinema \(error.localizedDescription.debugDescription)")
                }
            }
        }
    }
    
    @IBAction func validateConfigAction(_ sender: UIButton) {
        self.configureWidget()
    }
    
}
