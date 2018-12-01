//
//  BaseWebService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Alamofire

enum Result<Value> {
    case success(Value)
    case failure(NetworkError)
}

struct NetworkError: Error {
    private let message: String

    var localizedDescription: String {
        return message.localized
    }

    init(message: String) {
        self.message = message
    }
}

class BaseWebService {
    func handle(_ error: Error) -> NetworkError {
        guard let error = error as? URLError else { return NetworkError(message: Texts.NetworkError.unknown) }

        switch error.code {
        case .notConnectedToInternet:
            return NetworkError(message: Texts.NetworkError.notConnectedToInternet)
        case .networkConnectionLost:
            return NetworkError(message: Texts.NetworkError.networkConnectionLost)
        case .timedOut:
            return NetworkError(message: Texts.NetworkError.timedOut)
        default:
            return NetworkError(message: Texts.NetworkError.unknown)
        }
    }
}
