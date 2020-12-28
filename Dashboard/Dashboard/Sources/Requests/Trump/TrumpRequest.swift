//
//  TrumpRequest.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation
import Alamofire

class TrumpRequest {
    private let baseUrlString = Constants.baseApiUrl + "trump/"

    func requestTrumpQuote(completionHandler: @escaping (Result<TrumpModel, ErrorType>) -> Void) {
        let requestUrlString = self.baseUrlString + "quote"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(requestUrlString, method: .get, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let trumpModel = self.parseJsonTrumpQuote(trumpData: data)
                    {
                        return completionHandler(.success(trumpModel))
                    }
                    else if let errorModel = RequestsCommon.parseJsonError(dataError: data) {
                        return completionHandler(.failure(.BadCall(errorModel)))
                    }
                }
            } else {
                print("===> [REQUEST Error] while requesting trump quote to Dashboard")
                completionHandler(.failure(.ImplementationError(ParsingError(message: response.error.debugDescription))))
            }
        }
    }
    
    func parseJsonTrumpQuote(trumpData: Data) -> TrumpModel? {
        let decoder = JSONDecoder()
        var apiResponse: TrumpModel?
        do {
            let decodedData = try decoder.decode(TrumpModel.self, from: trumpData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while requesting trump quote data:\n", error)
        }
        return nil
    }
}
