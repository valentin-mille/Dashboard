//
//  MovieRequests.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation
import Alamofire

class MovieRequest {
    let baseUrlString = Constants.baseApiUrl + "movie/"
    
    func requestMovieTrend(mediaType: String, windowTime: String, completionHandler: @escaping (Result<[MovieModel], ErrorType>) -> Void) {
        let requestUrlString = self.baseUrlString + "\(mediaType)/\(windowTime)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(requestUrlString, method: .get, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let movieModelList = self.parseJsonFrenchDepartment(movieData: data)
                    {
                        return completionHandler(.success(movieModelList))
                    }
                    else if let errorModel = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(errorModel)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while requesting movie data for Dashboard")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }
    
    func parseJsonFrenchDepartment(movieData: Data) -> [MovieModel]? {
        let decoder = JSONDecoder()
        var apiResponse: [MovieModel]?
        do {
            let decodedData = try decoder.decode([MovieModel].self, from: movieData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while requesting movie data:\n", error)
        }
        return nil
    }
}
