//
//  PlaceSuggestionApiModel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 08..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Foundation

struct PlaceSuggestionRequestDTO: Codable {
    let latitude: Double
    let longitude: Double
    let name: String
    let info: String
    let type: String
    let senderEmail: String
    let image1: Data
    let image2: Data
    let image3: Data?
    let image4: Data?
}
