//
//  CovidWidgetConfigViewController.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import UIKit

class CovidWidgetConfigViewController: WidgetConfigViewController {
    private let covidRequest = CovidRequest()
    private let frenchDepartmentRequest = FrenchDepartmentRequest()
    @IBOutlet var infoChoicePicker: UIPickerView!
    @IBOutlet var displayChoiceView: UIView!
    var pickerData = [["France", "French department"]]
    private let refreshTimeList = ["Every day", "Every week"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoChoicePicker.delegate = self
        self.infoChoicePicker.dataSource = self
        self.setupPickerData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.displayChoiceView.layer.cornerRadius = self.viewCorderRadius
    }
    
    func setupPickerData() {
        var departmentArray: [String] = []
        self.frenchDepartmentRequest.requestFrenchDepartment { (result) in
            switch result {
                case .success(let frenchDepartmentList):
                    for frenchDepartmentModel in frenchDepartmentList {
                        departmentArray.append(frenchDepartmentModel.name)
                    }
                    self.pickerData.append(departmentArray)
                    self.infoChoicePicker.reloadAllComponents()
                case .failure(let error):
                    print("[Error] while configuring department \(error.localizedDescription.debugDescription)")
            }
        }
    }
    
    override func configureWidget() {
        let selectedRowValue = self.pickerData[0][self.infoChoicePicker.selectedRow(inComponent: 0)]
        let departmentSelected = self.pickerData[1][self.infoChoicePicker.selectedRow(inComponent: 1)]
        if selectedRowValue == self.pickerData[0][0] {
            self.covidRequest.requestFranceCovidInformations { (result) in
                switch result {
                    case .success(let covidModel):
                        print(covidModel.death)
                        self.delegate?.updateWidget(widget: .covidFrench(covidModel), selectedService: self.selectedService)
                        self.returnToHomeVC()
                    case .failure(let error):
                        print("[Error] while configuring covid \(error.localizedDescription.debugDescription)")
                }
            }
        } else if (selectedRowValue == self.pickerData[0][1]) {
            self.covidRequest.requestCovidFranceDeparmentInformations(department: departmentSelected) { (result) in
                switch result {
                    case .success(let covidModel):
                        print(covidModel.cured)
                        self.delegate?.updateWidget(widget: .covidFrenchDepartment(covidModel), selectedService: self.selectedService)
                        self.returnToHomeVC()
                    case .failure(let error):
                        print("[Error] while configuring covid for department \(error.localizedDescription.debugDescription)")
                }
            }
            
        }
    }
    
    @IBAction func validateConfigAction(_ sender: UIButton) {
        self.configureWidget()
    }
}

//MARK: - PickerViewDelegate, PickerViewDatasource

extension CovidWidgetConfigViewController {
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
