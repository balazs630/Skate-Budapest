//
//  PlaceWebService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 25..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Alamofire

final class PlaceWebService: BaseWebService {
    var baseUrl: String {
        switch environment {
        case .development:
            return "http://localhost:8080"
        case .production:
            return "https://skatebudapest.libertyskate.hu"
        }
    }

    var apiKey: String {
        switch environment {
        case .development:
            return "1da550b6-086d-456a-8968-948228cc07e1"
        case .production:
            return "96b75a50-5ae0-4ba6-967c-9b14ef32e7f5"
        }
    }
}

extension PlaceWebService {
    fileprivate enum Slug {
        static let apiVersionPath = "/api/v1"
        static let placePath = "\(apiVersionPath)/places"
        static let placeDataVersionPath = "\(placePath)/data_version"
        static let placeSuggestionPath = "\(apiVersionPath)/suggest_place"
    }

    fileprivate enum Parameter {
        static let language = "lang"
        static let status = "status"
        static let defaultLanguageCode = "en"
    }
}

// MARK: Network requests
extension PlaceWebService {
    func getPlaces(completion: @escaping (Result<[PlaceApiModel]>) -> Void) {
        let url = requestUrl(for: Slug.placePath)
        let headers = HTTPHeaders(["Api-Key": apiKey])
        let queryParams = [
            Parameter.language: Locale.current.languageCode ?? Parameter.defaultLanguageCode,
            Parameter.status: WaypointStatus.active.rawValue
        ]

        AF.request(url, method: .get, parameters: queryParams, headers: headers)
            .validate()
            .responseDecodable(of: [PlaceApiModel].self) { response in
                response.log()

                switch response.result {
                case .success(let values):
                    completion(Result.success(values))
                case .failure(let error):
                    completion(Result.failure(self.handle(error)))
                }
        }
    }

    func getPlaceDataVersion(completion: @escaping (Result<PlaceDataVersionApiModel>) -> Void) {
        let url = requestUrl(for: Slug.placeDataVersionPath)
        let headers = HTTPHeaders(["Api-Key": apiKey])

        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: PlaceDataVersionApiModel.self) { response in
                response.log()

                switch response.result {
                case .success(let value):
                    completion(Result.success(value))
                case .failure(let error):
                    completion(Result.failure(self.handle(error)))
                }
        }
    }

    func postPlaceSuggestion(place: PlaceSuggestionApiModel, completion: @escaping (Result<Void>) -> Void) {
        let url = requestUrl(for: Slug.placeSuggestionPath)
        let headers = HTTPHeaders(["Api-Key": apiKey])

        AF.upload(
            multipartFormData: { formData in
                formData.append(place.name.data, withName: "name")
                formData.append(place.info.data, withName: "info")
                formData.append(place.type.data, withName: "type")
                formData.append(place.senderEmail.data, withName: "senderEmail")
                formData.append(place.latitude.data, withName: "latitude")
                formData.append(place.longitude.data, withName: "longitude")
                formData.append(place.image1, withName: "image1", mimeType: place.image1.mimeType)
                formData.append(place.image2, withName: "image2", mimeType: place.image2.mimeType)
                if let image3 = place.image3 {
                    formData.append(image3, withName: "image3", mimeType: image3.mimeType)
                }
                if let image4 = place.image4 {
                    formData.append(image4, withName: "image4", mimeType: image4.mimeType)
                }
            },
            to: url,
            method: .post,
            headers: headers)
        .validate()
        .responseJSON { response in
            response.log()

            switch response.result {
            case .success:
                completion(Result.success(()))
            case .failure(let error):
                completion(Result.failure(self.handle(error)))
            }
        }
    }
}
