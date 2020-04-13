//
//  PlaceReportApiModel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2020. 04. 13..
//  Copyright © 2020. Horváth Balázs. All rights reserved.
//

struct PlaceReportApiModel: Codable {
    let placeId: String
    let placeName: String
    let senderEmail: String
    let reportText: String
}
