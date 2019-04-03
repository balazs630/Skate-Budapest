//
//  UIImageExtension.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 04. 03..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIImage {
    func compressSizeBelow(kiloByte: Int) -> UIImage {
        let sizeInBytes = kiloByte * 1024
        var needCompress = true
        var imageData: Data?
        var compressingValue = CGFloat(1.0)

        while needCompress, compressingValue > 0 {
            if let data = self.jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imageData = data
                } else {
                    compressingValue -= 0.2
                }
            }
        }

        return UIImage(data: imageData ?? self.jpegData(compressionQuality: 0.5)!)!
    }
}
