//
//  GithubWidgetConfigViewController.swift
//  Dashboard
//
//  Created by Valentin Mille on 05/12/2020.
//

import UIKit

class GithubWidgetConfigViewController: WidgetConfigViewController {
    private let githubRequest = GithubRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshView.isHidden = true
        self.refreshWidgetPicker.isHidden = true
    }
    
    override func configureWidget() {
        if let accessToken = self.selectedService.oauthToken {
            let githubModel = GithubModel.init(name: "", accessToken: accessToken)
            self.delegate?.updateWidget(widget: .github(githubModel), selectedService: self.selectedService)
            self.returnToHomeVC()
        }
    }
    
    @IBAction func validateConfigAction(_ sender: UIButton) {
        self.configureWidget()
    }
}
