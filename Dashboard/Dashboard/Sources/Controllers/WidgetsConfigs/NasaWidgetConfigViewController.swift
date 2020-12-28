//
//  NasaWidgetConfigViewController.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import UIKit

class NasaWidgetConfigViewController: WidgetConfigViewController {
    private let nasaRequest = NasaRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshData = ["Every days", "Every weeks"]
    }
    
    override func configureWidget() {
        self.nasaRequest.requestNasaImage { (result) in
            switch result {
                case .success(let nasaModel):
                    self.delegate?.updateWidget(widget: .nasa(nasaModel), selectedService: self.selectedService)
                    self.returnToHomeVC()
                case .failure(let error):
                    print("[Error] while configuring nasa \(error.localizedDescription.debugDescription)")
            }
        }
    }

    @IBAction func validateConfigAction(_ sender: UIButton) {
        self.configureWidget()
    }
}
