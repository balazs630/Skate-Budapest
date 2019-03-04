//
//  PlaceWebService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 25..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Alamofire

extension PlaceWebService {
    fileprivate enum Slug {
        static let apiVersionPath = "/v1"
        static let placePath = "\(apiVersionPath)/places"
        static let placeInfoPath = "\(placePath)/info"
    }

    fileprivate enum Parameter {
        static let language = "lang"
        static let defaultLanguageCode = "en"
    }
}

class PlaceWebService: BaseWebService {
    var environment: ApiEnvironment

    init(environment: ApiEnvironment) {
        self.environment = environment
    }
}

// MARK: Network requests
extension PlaceWebService {
    func getPlaces(completion: @escaping (Result<[PlaceApiModel]>) -> Void) {
        let url = requestUrl(for: Slug.placePath)
        let queryParams: Parameters = [
            Parameter.language: Locale.current.languageCode ?? Parameter.defaultLanguageCode
        ]

        Alamofire.request(url, method: .get, parameters: queryParams).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let places = try self.decoder.decode([PlaceApiModel].self, from: data)
                    completion(Result.success(places))
                } catch {
                    completion(Result.failure(self.handle(error)))
                }
            case .failure(let error):
                completion(Result.failure(self.handle(error)))
            }
        }
    }

    func getPlaceInfo(completion: @escaping (Result<PlaceInfoApiModel>) -> Void) {
        let url = requestUrl(for: Slug.placeInfoPath)

        Alamofire.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let info = try self.decoder.decode(PlaceInfoApiModel.self, from: data)
                    completion(Result.success(info))
                } catch {
                    completion(Result.failure(self.handle(error)))
                }
            case .failure(let error):
                completion(Result.failure(self.handle(error)))
            }
        }
    }
}
