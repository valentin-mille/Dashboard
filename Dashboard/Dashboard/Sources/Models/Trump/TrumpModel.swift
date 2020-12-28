//
//  TrumpModel.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation

struct TrumpModel: Decodable {
    let quote: String
    
    private enum CodingKeys: String, CodingKey {
        case quote = "value"
    }
}
