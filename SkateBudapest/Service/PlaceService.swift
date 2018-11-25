//
//  PlaceService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 25..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Alamofire

class PlaceService {
    private let decoder = JSONDecoder()

    fileprivate enum Slug {
        static let apiVersionPath = "v1"
        static let placePath = "\(apiVersionPath)/places"
        static let placeDataInfoPath = "\(placePath)/info"
    }

    func getWaypoints(completionHandler: @escaping ([Place]?, Error?) -> Void) {
        guard let requestUrl = URL(string: "\(Constant.baseUrl)\(Slug.placePath)") else {
            return
        }

        Alamofire.request(requestUrl, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let places = try self.decoder.decode([Place].self, from: data)
                    completionHandler(places, nil)
                } catch {
                    completionHandler(nil, error)
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }

    func getplaceDataInfo(completionHandler: @escaping (PlaceDataInfo?, Error?) -> Void) {
        guard let requestUrl = URL(string: "\(Constant.baseUrl)\(Slug.placeDataInfoPath)") else {
            return
        }

        Alamofire.request(requestUrl, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let info = try self.decoder.decode(PlaceDataInfo.self, from: data)
                    completionHandler(info, nil)
                } catch {
                    completionHandler(nil, error)
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
