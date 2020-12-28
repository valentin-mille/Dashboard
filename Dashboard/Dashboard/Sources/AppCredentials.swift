//
//  AppCredentials.swift
//  Dashboard
//
//  Created by Valentin Mille on 21/11/2020.
//

import Foundation

struct AppCredentialsLoader {
    static var plistDict = Dictionary<String, Dictionary<String, String>>()
    
    init() {
        let url = Bundle.main.url(forResource: "Credentials", withExtension: "plist")
        if let urlFound = url {
            let credentialsData = try! Data(contentsOf: urlFound)
            let plistData = try! PropertyListSerialization.propertyList(from: credentialsData, options: [], format: nil)
            AppCredentialsLoader.plistDict = plistData as! Dictionary
        }
    }
}

struct AppCredentials {
    static let clientIdKey: String = "clientId"
    static let clientSecretKey: String = "clientSecret"
    static let credentials = AppCredentialsLoader.plistDict
}
