//
//  TimeIntervalExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 09. 23..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

extension TimeInterval {
    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }

    private var hours: Int {
        return Int(self) / 3600
    }

    var stringTime: String {
        if hours != 0 {
            return "\(hours) \(Texts.PlaceDetails.hour.localized)"
                + " \(minutes) \(Texts.PlaceDetails.minutes.localized)"
        } else {
            return "\(minutes) \(Texts.PlaceDetails.minutes.localized)"
        }
    }
}
