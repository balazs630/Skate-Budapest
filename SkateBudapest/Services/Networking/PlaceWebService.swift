//
//  PlaceWebService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 25..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Alamofire

final class PlaceWebService: BaseWebService { }

extension PlaceWebService {
    fileprivate enum Slug {
        static let apiVersionPath = "/v1"
        static let placePath = "\(apiVersionPath)/places"
        static let placeInfoPath = "\(placePath)/info"
        static let placeSuggestionPath = "\(apiVersionPath)/suggestplace"
    }

    fileprivate enum Parameter {
        static let language = "lang"
        static let defaultLanguageCode = "en"
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

    func postPlaceSuggestion(newPlace: PlaceSuggestionApiModel,
                             completion: @escaping (Result<DataResponse<Any>>) -> Void) {
        let url = requestUrl(for: Slug.placeSuggestionPath)

        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(newPlace.name.data, withName: "name")
                multipartFormData.append(newPlace.info.data, withName: "info")
                multipartFormData.append(newPlace.type.data, withName: "type")
                multipartFormData.append(newPlace.senderEmail.data, withName: "senderEmail")
                multipartFormData.append(newPlace.latitude.data, withName: "latitude")
                multipartFormData.append(newPlace.longitude.data, withName: "longitude")
                multipartFormData.append(newPlace.image1, withName: "image1", mimeType: "image/jpeg")
                multipartFormData.append(newPlace.image2, withName: "image2", mimeType: "image/jpeg")
                if let image3 = newPlace.image3 {
                    multipartFormData.append(image3, withName: "image3", mimeType: "image/jpeg")
                }
                if let image4 = newPlace.image4 {
                    multipartFormData.append(image4, withName: "image4", mimeType: "image/jpeg")
                }
            },
            to: url,
            method: .post,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
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
