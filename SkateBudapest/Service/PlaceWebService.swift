//
//  PlaceWebService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 25..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Alamofire

class PlaceWebService: BaseWebService {
    private let decoder = JSONDecoder()

    fileprivate enum Slug {
        static let apiVersionPath = "/v1"
        static let placePath = "\(apiVersionPath)/places"
        static let placeInfoPath = "\(placePath)/info"
    }

    func getPlaces(completionHandler: @escaping (Result<[PlaceApiModel]>) -> Void) {
        guard let requestUrl = URL(string: "\(Constant.baseUrl)\(Slug.placePath)") else {
            return
        }

        Alamofire.request(requestUrl, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let places = try self.decoder.decode([PlaceApiModel].self, from: data)
                    completionHandler(Result.success(places))
                } catch {
                    completionHandler(Result.failure(self.handle(error)))
                }
            case .failure(let error):
                completionHandler(Result.failure(self.handle(error)))
            }
        }
    }

    func getPlaceInfo(completionHandler: @escaping (Result<PlaceInfoApiModel>) -> Void) {
        guard let requestUrl = URL(string: "\(Constant.baseUrl)\(Slug.placeInfoPath)") else {
            return
        }

        Alamofire.request(requestUrl, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let info = try self.decoder.decode(PlaceInfoApiModel.self, from: data)
                    completionHandler(Result.success(info))
                } catch {
                    completionHandler(Result.failure(self.handle(error)))
                }
            case .failure(let error):
                completionHandler(Result.failure(self.handle(error)))
            }
        }
    }
}
