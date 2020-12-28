//
//  CovidRequests.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation
import Alamofire

class CovidRequest {
    let baseUrlString = Constants.baseApiUrl + "covid/"
    
    func requestFranceCovidInformations(completionHandler: @escaping (Result<CovidFrenchInfoModel, ErrorType>) -> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(self.baseUrlString, method: .get, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let cinemaModel = self.parseJsonCovidFranceInfos(covidFrenchData: data)
                    {
                        return completionHandler(.success(cinemaModel))
                    }
                    else if let errorModel = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(errorModel)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while requesting french covid for Dashboard")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }
    
    func parseJsonCovidFranceInfos(covidFrenchData: Data) -> CovidFrenchInfoModel? {
        let decoder = JSONDecoder()
        var apiResponse: CovidFrenchInfoModel?
        do {
            let decodedData = try decoder.decode(CovidFrenchInfoModel.self, from: covidFrenchData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while requesting french covid data:\n", error)
        }
        return nil
    }
    
    func requestCovidFranceDeparmentInformations(department: String, completionHandler: @escaping (Result<CovidFrenchDepartmentInfoModel, ErrorType>) -> Void) {
        let requestUrlString = (self.baseUrlString + department).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        if let stringUrl = requestUrlString {
            AF.request(stringUrl, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                if response.error == nil {
                    if let data = response.data {
                        if let covidDepartmentModel = self.parseJsonCovidFranceDepartmentInfos(covidDepartmentData: data)
                        {
                            return completionHandler(.success(covidDepartmentModel))
                        }
                        else if let errorModel = RequestsCommon.parseJsonError(dataError: data) {
                            return completionHandler(.failure(.BadCall(errorModel)))
                        }
                    }
                } else {
                    print("===> [REQUEST Error] while requesting french department for Dashboard")
                    completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
                }
            }
        }
    }
    
    func parseJsonCovidFranceDepartmentInfos(covidDepartmentData: Data) -> CovidFrenchDepartmentInfoModel? {
        let decoder = JSONDecoder()
        var apiResponse: CovidFrenchDepartmentInfoModel?
        do {
            let decodedData = try decoder.decode(CovidFrenchDepartmentInfoModel.self, from: covidDepartmentData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while requesting french department covid data:\n", error)
        }
        return nil
    }
}
