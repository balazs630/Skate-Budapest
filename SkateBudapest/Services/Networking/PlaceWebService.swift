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
        let headers = ["Api-Key": apiKey]
        let queryParams: Parameters = [
            Parameter.language: Locale.current.languageCode ?? Parameter.defaultLanguageCode,
            Parameter.status: WaypointStatus.active.rawValue
        ]

        Alamofire.request(url, method: .get, parameters: queryParams, headers: headers)
            .validate()
            .responseJSON { response in
                response.log()

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

    func getPlaceDataVersion(completion: @escaping (Result<PlaceDataVersionApiModel>) -> Void) {
        let url = requestUrl(for: Slug.placeDataVersionPath)
        let headers = ["Api-Key": apiKey]

        Alamofire.request(url, method: .get, headers: headers)
            .validate()
            .responseJSON { response in
                response.log()

                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let info = try self.decoder.decode(PlaceDataVersionApiModel.self, from: data)
                        completion(Result.success(info))
                    } catch {
                        completion(Result.failure(self.handle(error)))
                    }
                case .failure(let error):
                    completion(Result.failure(self.handle(error)))
                }
        }
    }

    func postPlaceSuggestion(newPlace: PlaceSuggestionApiModel,
                             completion: @escaping (Result<DataResponse<Any>>) -> Void) {
        let url = requestUrl(for: Slug.placeSuggestionPath)
        let headers = ["Api-Key": apiKey]

        Alamofire.upload(
            multipartFormData: { formData in
                formData.append(newPlace.name.data, withName: "name")
                formData.append(newPlace.info.data, withName: "info")
                formData.append(newPlace.type.data, withName: "type")
                formData.append(newPlace.senderEmail.data, withName: "senderEmail")
                formData.append(newPlace.latitude.data, withName: "latitude")
                formData.append(newPlace.longitude.data, withName: "longitude")
                formData.append(newPlace.image1, withName: "image1", mimeType: newPlace.image1.mimeType)
                formData.append(newPlace.image2, withName: "image2", mimeType: newPlace.image2.mimeType)
                if let image3 = newPlace.image3 {
                    formData.append(image3, withName: "image3", mimeType: image3.mimeType)
                }
                if let image4 = newPlace.image4 {
                    formData.append(image4, withName: "image4", mimeType: image4.mimeType)
                }
            },
            to: url,
            method: .post,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload
                        .validate()
                        .responseJSON { response in
                            response.log()

                            if let error = response.error {
                                completion(Result.failure(self.handle(error)))
                            }
                            completion(Result.success(response))
                        }
                case .failure(let error):
                    completion(Result.failure(self.handle(error)))
                }
            }
        )
    }
}
