//
//  BaseWebService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Alamofire

enum ApiEnvironment {
    case development
    case production
}

protocol BaseWebService {
    var environment: ApiEnvironment { get }
    var baseUrl: String { get }
    var apiKey: String? { get }
    var decoder: JSONDecoder { get }

    func requestUrl(for path: String) -> String
    func handle(_ error: Error) -> NetworkError
}

// MARK: Default implementation
extension BaseWebService {
    var environment: ApiEnvironment {
        return .production
    }

    var apiKey: String? {
        return nil
    }

    var decoder: JSONDecoder {
        return JSONDecoder()
    }

    func requestUrl(for path: String) -> String {
        return baseUrl + path
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
