//
//  PlaceSuggestionApiModel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 08..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Foundation

struct PlaceSuggestionApiModel: Codable {
    var name: String
    var info: String
    var latitude: Double
    var longitude: Double
    var type: String
    var senderEmail: String
    var image1: Data
    var image2: Data
    var image3: Data?
    var image4: Data?

    init(displayItem: PlaceSuggestionDisplayItem) {
        self.name = displayItem.name
        self.info = displayItem.info
        self.latitude = displayItem.coordinate.latitude
        self.longitude = displayItem.coordinate.longitude
        self.type = displayItem.type
        self.senderEmail = displayItem.senderEmail
        self.image1 = displayItem.image1.jpegData(compressionQuality: 1) ?? Data()
        self.image2 = displayItem.image2.jpegData(compressionQuality: 1) ?? Data()
        self.image3 = displayItem.image3?.jpegData(compressionQuality: 1)
        self.image4 = displayItem.image4?.jpegData(compressionQuality: 1)
    }
}
