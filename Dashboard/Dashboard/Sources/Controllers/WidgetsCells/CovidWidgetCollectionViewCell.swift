//
//  CovidWidgetCollectionViewCell.swift
//  Dashboard
//
//  Created by Valentin Mille on 15/12/2020.
//

import UIKit

class CovidWidgetCollectionViewCell: WidgetCollectionViewCell {
    static let widgetIdentifier = "CovidWidgetCell"
    @IBOutlet var statsLabel: UILabel!
    private let covidRequest = CovidRequest()
    private var covidFrenchModel: CovidFrenchInfoModel? = nil
    private var covidFrenchDepartmentModel: CovidFrenchDepartmentInfoModel? = nil
    private var currentDepartment = ""
    
    static func widgetNib() -> UINib {
        return UINib(nibName: "CovidWidgetCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func configureWidget(serviceModel: Constants.ServicesModelData) {
        switch serviceModel {
            case .covidFrench(let covidModel):
                self.updateCovidFrench(covidModel: covidModel)
            case .covidFrenchDepartment(let covidModel):
                self.updateCovidFrenchDepartment(covidModel: covidModel)
            default:
                break
        }
    }
    
    func updateCovidFrench(covidModel: CovidFrenchInfoModel) {
        self.covidFrenchModel = covidModel
        let message = "Last Update: \(covidModel.date)\nDeath: \(covidModel.death)\nCured: \(covidModel.cured)"
        self.statsLabel.text = message
    }
    
    func updateCovidFrenchDepartment(covidModel: CovidFrenchDepartmentInfoModel) {
        self.covidFrenchDepartmentModel = covidModel
        let message = "Last Update: \(covidModel.date)\nDeath: \(covidModel.death)\nCured: \(covidModel.cured)"
        self.statsLabel.text = message
        self.currentDepartment = covidModel.name
    }
    
    @IBAction override func refreshWidget(_ sender: UIButton) {
        if self.covidFrenchModel != nil {
            self.covidRequest.requestFranceCovidInformations { (response) in
                switch response {
                    case .success(let covidModel):
                        self.updateCovidFrench(covidModel: covidModel)
                    case .failure(let error):
                        print("[Error] during covid french refresh widget data \(error.localizedDescription.debugDescription)")
                }
            }
        } else {
            self.covidRequest.requestCovidFranceDeparmentInformations(department: self.currentDepartment) { (response) in
                switch response {
                    case .success(let covidModel):
                        self.updateCovidFrenchDepartment(covidModel: covidModel)
                    case .failure(let error):
                        print("[Error] during covid french department refresh widget data \(error.localizedDescription.debugDescription)")
                }
            }
        }
    }
    
}
