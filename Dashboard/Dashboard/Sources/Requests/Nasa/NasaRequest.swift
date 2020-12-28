//
//  NasaRequest.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation
import Alamofire

class NasaRequest {
    let baseUrlString = Constants.baseApiUrl + "nasa/"
    

    func requestNasaImage(completionHandler: @escaping (Result<NasaModel, ErrorType>) -> Void) {
        let requestUrlString = self.baseUrlString + "apod"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(requestUrlString, method: .get, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let nasaModel = self.parseJsonNasaApod(nasaData: data)
                    {
                        return completionHandler(.success(nasaModel))
                    }
                    else if let errorModel = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(errorModel)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while requesting nasa apod to Dashboard")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }
    
    func parseJsonNasaApod(nasaData: Data) -> NasaModel? {
        let decoder = JSONDecoder()
        var apiResponse: NasaModel?
        do {
            let decodedData = try decoder.decode(NasaModel.self, from: nasaData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while requesting nasa apod data:\n", error)
        }
        return nil
    }
}
