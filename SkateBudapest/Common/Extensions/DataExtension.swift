//
//  DataExtension.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 06. 22..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Foundation

extension Data {
    var mimeType: String {
        var byte: UInt8 = 0
        copyBytes(to: &byte, count: 1)

        switch byte {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D :
            return "image/tiff"
        case 0x46:
            return "text/plain"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        default:
            return "application/octet-stream"
        }
    }
}
