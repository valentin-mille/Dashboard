//
//  microServiceModel.swift
//  Dashboard
//
//  Created by Valentin Mille on 21/11/2020.
//

import Foundation

struct ServiceModel: Decodable {
    let serviceId: String
    let serviceName: String
    let urlImage: String
    let authorizeUrl: String?
    let accessToken: String?
    var oauthToken: String?
    var refreshToken: String?
}
