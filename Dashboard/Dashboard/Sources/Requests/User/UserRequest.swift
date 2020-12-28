//
//  UserRequests.swift
//  Dashboard
//
//  Created by Remi Poulenard on 28/11/2020.
//

import Foundation
import Alamofire

class UserRequest {
    private let baseUrlString = "http://localhost:8080/User/"

    //MARK: - POST CALLS
    
    func signInRequest(Username: String, Password: String, completionHandler: @escaping (Result<UserModel, ErrorType>) -> Void) {
        let requestUrlString = self.baseUrlString + "signin"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let parameters: [String: String] = [
            "username": Username,
            "password": Password,
        ]
        
        AF.request(requestUrlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let accountBaseModel = self.parseJsonUser(userData: data)
                    {
                        return completionHandler(.success(accountBaseModel))
                    }
                    else if let errorModel = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(errorModel)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while logging in to Dashboard")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }
    
    func parseJsonUser(userData: Data) -> UserModel? {
        let decoder = JSONDecoder()
        var apiResponse: UserModel?
        do {
            let decodedData = try decoder.decode(UserModel.self, from: userData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while requesting user data:\n", error)
        }
        return nil
    }
    
    func signUpRequest(Username: String, Password: String, completionHandler: @escaping (Result<UserModel, ErrorType>) -> Void) {
        let requestUrlString = self.baseUrlString + "signup/"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let parameters: [String: String] = [
            "username": Username,
            "password": Password,
        ]
        AF.request(requestUrlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let accountBaseModel = self.parseJsonUser(userData: data)
                    {
                        return completionHandler(.success(accountBaseModel))
                    }
                    if let error = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(error)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while signing up to Dasboard")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }

    func LogoutRequest(userID: String, completionHandler: @escaping (Result<Bool, ErrorType>) -> Void) {
        let requestUrlString = self.baseUrlString + "User/" + userID
        AF.request(requestUrlString, method: .post).responseJSON { (response) in
            if response.error == nil {
                return completionHandler(.success(true))
            } else {
                print("===> [REQUEST Error] while logging out from Dashboard")
                return completionHandler(.success(false))
            }
        }
    }
}
