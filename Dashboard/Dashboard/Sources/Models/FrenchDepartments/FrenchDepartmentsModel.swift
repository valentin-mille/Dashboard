//
//  FrenchDepartmentsModel.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation

class FrenchDepartmentsModel: Decodable {
    let name: String
    let code: String
    let regionCode: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "nom"
        case code = "code"
        case regionCode = "codeRegion"
    }
}
