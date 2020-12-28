//
//  FrenchDepartmentRequests.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation
import Alamofire

class FrenchDepartmentRequest {
    let baseUrlString = "https://geo.api.gouv.fr"
    
    func requestFrenchDepartment(completionHandler: @escaping (Result<[FrenchDepartmentsModel], ErrorType>) -> Void) {
        let requestUrlString = self.baseUrlString + "/departements?"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(requestUrlString, method: .get, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let frenchDepartmentModel = self.parseJsonFrenchDepartment(frenchDepartmentData: data)
                    {
                        return completionHandler(.success(frenchDepartmentModel))
                    }
                    else if let errorModel = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(errorModel)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while requesting france department to Dashboard")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }
    
    func parseJsonFrenchDepartment(frenchDepartmentData: Data) -> [FrenchDepartmentsModel]? {
        let decoder = JSONDecoder()
        var apiResponse: [FrenchDepartmentsModel]?
        do {
            let decodedData = try decoder.decode([FrenchDepartmentsModel].self, from: frenchDepartmentData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while requesting france covid data:\n", error)
        }
        return nil
    }
}
