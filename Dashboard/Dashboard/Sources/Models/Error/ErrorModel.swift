//
//  ErrorModel.swift
//  Dashboard
//
//  Created by Remi Poulenard on 28/11/2020.
//

import Foundation

struct ErrorModel: Decodable {
    var error: String
    var request: String
    var method: String
}
