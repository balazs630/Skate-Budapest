//
//  PlaceSuggestionDisplayItem.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 15..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

struct PlaceSuggestionDisplayItem {
    var latitude: Double
    var longitude: Double
    var name: String
    var info: String
    var type: String
    var senderEmail: String
    var image1: UIImage
    var image2: UIImage
    var image3: UIImage?
    var image4: UIImage?

    init(latitude: Double = 0.0,
         longitude: Double = 0.0,
         name: String = "",
         info: String = "",
         type: String = "",
         senderEmail: String = "",
         image1: UIImage = UIImage(),
         image2: UIImage = UIImage()) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.info = info
        self.type = type
        self.senderEmail = senderEmail
        self.image1 = image1
        self.image2 = image2
    }
}
