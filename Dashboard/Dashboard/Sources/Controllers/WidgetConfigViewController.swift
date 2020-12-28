//
//  WidgetConfigViewController.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import UIKit
import Nuke

class WidgetConfigViewController: UIViewController {
    @IBOutlet var serviceImage: UIImageView!
    @IBOutlet var refreshWidgetPicker: UIPickerView!
    @IBOutlet var refreshView: UIView!
    var refreshData: [String] = []
    var serviceImageString: String = ""
    var serviceName = ""
    let viewCorderRadius: CGFloat = 15
    var selectedService: ServiceModel!
    weak var delegate: UpdateWidgetToService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshWidgetPicker.delegate = self
        self.refreshWidgetPicker.dataSource = self
        if let unpackedUrl = URL(string: self.serviceImageString) {
            Nuke.loadImage(with: unpackedUrl, into: self.serviceImage)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = self.serviceName
        self.serviceImage.layer.cornerRadius = self.serviceImage.frame.height / 2
        self.view.backgroundColor = UIColor(named: Constants.Color.backgroundColor)
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.refreshView.layer.cornerRadius = 15
        self.refreshView.backgroundColor = UIColor(named: Constants.Color.secondContainerColor)
    }
    
    func configureWidget() {
        
    }
    
    func configureRefreshTime() {
        
    }
    
    func returnToHomeVC() {
        if let homeVC = self.navigationController?.viewControllers[1] as? HomeViewController {
            self.navigationController?.popToViewController(homeVC, animated: true)
        }
    }
    
    func deactivateRefreshView() {
        self.refreshView.isHidden = true
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension WidgetConfigViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.refreshData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.refreshData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: self.refreshData[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: Constants.Color.fontColor)!])
    }
}
