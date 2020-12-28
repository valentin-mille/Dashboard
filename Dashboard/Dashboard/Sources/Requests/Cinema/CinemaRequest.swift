//
//  CinemaRequests.swift
//  Dashboard
//
//  Created by Remi Poulenard on 28/11/2020.
//

import Foundation
import Alamofire

class CinemaRequest {
    private let baseUrlString = Constants.baseApiUrl + "cinema/"

    func requestCinemaInformations(movieTitle: String, completionHandler: @escaping (Result<CinemaModel, ErrorType>) -> Void) {
        let requestUrlString = self.baseUrlString + "movie/" + movieTitle
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(requestUrlString, method: .get, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let cinemaModel = self.parseJsonCinema(cinemaData: data)
                    {
                        return completionHandler(.success(cinemaModel))
                    }
                    else if let errorModel = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(errorModel)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while requesting cinema to Dashboard")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }
    
    func parseJsonCinema(cinemaData: Data) -> CinemaModel? {
        let decoder = JSONDecoder()
        var apiResponse: CinemaModel?
        do {
            let decodedData = try decoder.decode(CinemaModel.self, from: cinemaData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while requesting cinema data:\n", error)
        }
        return nil
    }
}
