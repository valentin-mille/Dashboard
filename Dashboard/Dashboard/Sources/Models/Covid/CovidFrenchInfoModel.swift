//
//  CovidModel.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation

struct CovidFrenchInfoModel: Decodable {
    let date: String
    let confirmedCases: Int
    let death: Int
    let hospitalized: Int
    let resuscitations: Int
    let cured: Int
    let newHospitalization: Int
    let newResuscitations: Int
    
    private enum CodingKeys: String, CodingKey {
        case date = "date"
        case confirmedCases = "casConfirmes"
        case death = "deces"
        case hospitalized = "hospitalises"
        case resuscitations = "reanimation"
        case cured = "gueris"
        case newHospitalization = "nouvellesHospitalisations"
        case newResuscitations = "nouvellesReanimations"
    }
}
