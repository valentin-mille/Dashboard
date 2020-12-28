//
//  ServiceRequest.swift
//  Dashboard
//
//  Created by Valentin Mille on 03/12/2020.
//

import Foundation
import Alamofire

class ServiceRequest {
    private let baseUrlString = Constants.baseApiUrl + "service/"
    
    func getServices(completionHandler: @escaping (Result<[ServiceModel], ErrorType>) -> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(self.baseUrlString, method: .get, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let serviceModel = self.parseJsonServices(serviceData: data)
                    {
                        return completionHandler(.success(serviceModel))
                    }
                    else if let errorModel = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(errorModel)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while requesting services to Dashboard:\n\(response.error.debugDescription)")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }
    
    func parseJsonServices(serviceData: Data) -> [ServiceModel]? {
        let decoder = JSONDecoder()
        var apiResponse: [ServiceModel]?
        do {
            let decodedData = try decoder.decode([ServiceModel].self, from: serviceData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while requesting services data:\n", error)
        }
        return nil
    }
    
    func getUserServicesByGuid(guid: String, completionHandler: @escaping (Result<[ServiceModel], ErrorType>) -> Void) {
        let requestUrlString = self.baseUrlString + "user/" + guid
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(requestUrlString, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let userServicesModel = self.parseJsonUserServices(userServicesData: data)
                    {
                        return completionHandler(.success(userServicesModel))
                    }
                    else if let errorModel = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(errorModel)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while getting user services in to Dashboard")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }
    
    func parseJsonUserServices(userServicesData: Data) -> [ServiceModel]? {
        let decoder = JSONDecoder()
        var apiResponse: [ServiceModel]?
        do {
            let decodedData = try decoder.decode([ServiceModel].self, from: userServicesData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while getting user services data:\n", error)
        }
        return nil
    }
    
    func parseJsonService(serviceData: Data) -> ServiceModel? {
        let decoder = JSONDecoder()
        var apiResponse: ServiceModel?
        do {
            let decodedData = try decoder.decode(ServiceModel.self, from: serviceData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while getting user service data:\n", error)
        }
        return nil
    }
    
    //MARK: - POST
    
    func addServiceToUser(userId: String, serviceId: String, completionHandler: @escaping (Result<ServiceModel, ErrorType>) -> Void) {
        let requestUrlString = self.baseUrlString + "user/\(userId)/\(serviceId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        AF.request(requestUrlString, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let addedService = self.parseJsonService(serviceData: data)
                    {
                        return completionHandler(.success(addedService))
                    }
                    if let error = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(error)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while adding service to user")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }
    
    
    //MARK: - DELETE
    
    func deleteServiceUser(userId: String, serviceId: String, completionHandler: @escaping (Result<ServiceModel, ErrorType>) -> Void) {
        let requestUrlString = self.baseUrlString + "user/\(userId)/\(serviceId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        AF.request(requestUrlString, method: .delete, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let deletedService = self.parseJsonService(serviceData: data)
                    {
                        return completionHandler(.success(deletedService))
                    }
                    if let error = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(error)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while deleting service to user")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }
    
    
}
