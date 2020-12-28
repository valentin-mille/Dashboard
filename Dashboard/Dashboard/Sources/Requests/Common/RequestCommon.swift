//
//  RequestCommon.swift
//  Dashboard
//
//  Created by Valentin Mille on 28/11/2020.
//

import Foundation

class RequestsCommon {
    static func parseJsonError(dataError: Data) -> ErrorModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var apiResponse: ErrorModel?
        do {
            let decodedData = try decoder.decode(ErrorModel.self, from: dataError)
            apiResponse = ErrorModel(error: decodedData.error, request: decodedData.request, method: decodedData.method)
            return apiResponse
        } catch {
            print("==> [JSON Error] while requesting User data:\n", error)
        }
        return nil
    }
}
