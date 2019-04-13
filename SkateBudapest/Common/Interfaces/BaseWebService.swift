//
//  BaseWebService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Alamofire

protocol BaseWebService {
    var defaultEnvironment: ApiEnvironment { get }
    var decoder: JSONDecoder { get }

    func requestUrl(for path: String) -> String
    func handle(_ error: Error) -> NetworkError
}

extension BaseWebService {
    var decoder: JSONDecoder {
        return JSONDecoder()
    }

    var defaultEnvironment: ApiEnvironment {
        return .production
    }

    func requestUrl(for path: String) -> String {
        return defaultEnvironment.url + path
    }

    func handle(_ error: Error) -> NetworkError {
        guard let error = error as? URLError else { return NetworkError(message: Texts.NetworkError.unknown.localized) }

        switch error.code {
        case .notConnectedToInternet:
            return NetworkError(message: Texts.NetworkError.notConnectedToInternet.localized)
        case .networkConnectionLost:
            return NetworkError(message: Texts.NetworkError.networkConnectionLost.localized)
        case .timedOut:
            return NetworkError(message: Texts.NetworkError.timedOut.localized)
        default:
            return NetworkError(message: Texts.NetworkError.unknown.localized)
        }
    }
}
