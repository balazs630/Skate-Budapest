//
//  BaseWebService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Alamofire

protocol BaseWebService {
    var environment: ApiEnvironment { get }
    var decoder: JSONDecoder { get }

    func requestUrl(for path: String) -> String
    func handle(_ error: Error) -> NetworkError
}

extension BaseWebService {
    var decoder: JSONDecoder {
        return JSONDecoder()
    }

    func requestUrl(for path: String) -> String {
        return environment.url + path
    }

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
