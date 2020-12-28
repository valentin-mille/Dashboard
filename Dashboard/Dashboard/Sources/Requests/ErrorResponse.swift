//
//  ErrorResponse.swift
//  Dashboard
//
//  Created by Remi Poulenard on 28/11/2020.
//

import Foundation

enum ErrorType: Error {
    case BadCall(ErrorModel)
    case ImplementationError(ParsingError)
}

struct ParsingError: Error {
    var errorMessage: String
    
    init(message: String) {
        self.errorMessage = message
    }
    
    func displayError() {
        print(self.errorMessage)
    }
}
