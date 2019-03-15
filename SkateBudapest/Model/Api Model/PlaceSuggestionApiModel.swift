//
//  PlaceSuggestionApiModel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 08..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Foundation

struct PlaceSuggestionApiModel: Codable {
    var latitude: Double
    var longitude: Double
    var name: String
    var info: String
    var type: String
    var senderEmail: String
    var image1: Data
    var image2: Data
    var image3: Data?
    var image4: Data?
}
