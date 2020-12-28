//
//  UserModel.swift
//  Dashboard
//
//  Created by Remi Poulenard on 28/11/2020.
//

import Foundation

struct UserModel: Decodable {
    var userId: String
    var username: String
    var password: String
    var services: [ServiceModel]?
}
