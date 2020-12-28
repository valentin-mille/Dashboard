//
//  WeatherRequest.swift
//  Dashboard
//
//  Created by Valentin Mille on 04/12/2020.
//

import Foundation
import Alamofire

class WeatherRequest {
    let baseStringUrl = Constants.baseApiUrl + "weather/"
    
    func requestWeatherInfo(placeName: String, completionHandler: @escaping (Result<WeatherModel, ErrorType>) -> Void) {
        let requestUrlString = self.baseStringUrl + placeName
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(requestUrlString, method: .get, headers: headers).responseJSON { response in
            if response.error == nil {
                if let data = response.data {
                    if let weatherModel = self.parseJsonWeatherInfos(weatherData: data)
                    {
                        return completionHandler(.success(weatherModel))
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
    
    func parseJsonWeatherInfos(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        var apiResponse: WeatherModel?
        do {
            let decodedData = try decoder.decode(WeatherModel.self, from: weatherData)
            apiResponse = decodedData
            return apiResponse
        } catch {
            print("==> [JSON Error] while requesting france covid data:\n", error)
        }
        return nil
    }
}
