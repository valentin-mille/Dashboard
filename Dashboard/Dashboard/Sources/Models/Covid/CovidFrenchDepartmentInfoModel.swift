//
//  CovidDepartmentInfoModel.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation

struct CovidFrenchDepartmentInfoModel: Decodable {
    let name: String
    let date: String
    let hospitalizations: Int
    let resuscitations: Int
    let newHospitalizations: Int
    let newResuscitations: Int
    let death: Int
    let cured: Int
    
    private enum CodingKeys: String, CodingKey {
        case name = "nom"
        case date = "date"
        case hospitalizations = "hospitalises"
        case resuscitations = "reanimation"
        case newHospitalizations = "nouvellesHospitalisations"
        case newResuscitations = "nouvellesReanimations"
        case death = "deces"
        case cured = "gueris"
    }
}
