//
//  PlaceDataInfo.swift
//  SkateBudapestBackend
//
//  Created by Horváth Balázs on 2018. 11. 23..
//

final class PlaceDataInfo: Codable {
    var dataVersion: String

    init(dataVersion: String) {
        self.dataVersion = dataVersion
    }
}
