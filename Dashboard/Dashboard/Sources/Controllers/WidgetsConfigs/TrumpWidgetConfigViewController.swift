//
//  TrumpWidgetConfigViewController.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import UIKit

class TrumpWidgetConfigViewController: WidgetConfigViewController {
    private let trumpRequest = TrumpRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshData = ["Every Minutes", "Every Days", "Every"]
    }
    
    override func configureWidget() {
        self.trumpRequest.requestTrumpQuote { (result) in
            switch result {
                case .success(let trumpModel):
                    self.delegate?.updateWidget(widget: .trump(trumpModel), selectedService: self.selectedService)
                    self.returnToHomeVC()
                case .failure(let error):
                    print("[Error] while configuring trump \(error.localizedDescription.debugDescription)")
            }
        }
    }

    @IBAction func validateConfigAction(_ sender: UIButton) {
        self.configureWidget()
    }
}
