//
//  GithubRequest.swift
//  Dashboard
//
//  Created by Valentin Mille on 15/12/2020.
//

import Foundation
import Alamofire
import OAuthSwift

class GithubRequest {
    let baseUrlString = "https://api.github.com/"
    
    func postGithubRepository(repositoryName: String, accessToken: String, completionHandler: @escaping (Result<GithubModel, ErrorType>) -> Void) {
        let requestUrlString = self.baseUrlString + "user/repos"
        let headers: HTTPHeaders = [
            "Authorization": "token \(accessToken)",
            "accept": "application/vnd.github.v3+json",
        ]
        let parameters: [String: String] = [
            "name": repositoryName,
            "description": "\(repositoryName) is an automatically generated repository",
        ]
        
        AF.request(requestUrlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let githubModel = self.parseJsonGithub(githubData: data)
                    {
                        return completionHandler(.success(githubModel))
                    }
                    else if let errorModel = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(errorModel)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while posting github repository to Dashboard")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }
    
    func parseJsonGithub(githubData: Data) -> GithubModel? {
        let decoder = JSONDecoder()
        var apiResponse: GithubModel?
        do {
            let decodedData = try decoder.decode(GithubModel.self, from: githubData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while posting github repository\(error)\n")
        }
        return nil
    }
}
