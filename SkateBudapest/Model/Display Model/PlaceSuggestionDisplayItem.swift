//
//  PlaceSuggestionDisplayItem.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 15..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Foundation

struct PlaceSuggestionDisplayItem {
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

    init(latitude: Double = 0.0,
         longitude: Double = 0.0,
         name: String = "",
         info: String = "",
         type: String = "",
         senderEmail: String = "",
         image1: Data = Data(),
         image2: Data = Data(),
         image3: Data = Data(),
         image4: Data = Data()) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.info = info
        self.type = type
        self.senderEmail = senderEmail
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
        self.image4 = image4
    }
}
