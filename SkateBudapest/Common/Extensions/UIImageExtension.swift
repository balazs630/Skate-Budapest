//
//  UIImageExtension.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 04. 03..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

enum ImageCompressionRate {
    case low
    case regular

    func compressionQulity() -> CGFloat {
        switch self {
        case .low:
            return 0.8
        case .regular:
            return 0.6
        }
    }

    func imageDimension() -> CGSize {
        switch self {
        case .low:
            return CGSize(width: 2048, height: 2048)
        case .regular:
            return CGSize(width: 1024, height: 1024)
        }
    }
}

extension UIImage {
    func compress(rate: ImageCompressionRate) -> UIImage {
        return compressBelow(rect: rate.imageDimension()).compress(compressionQuality: rate.compressionQulity())
    }

    func compress(compressionQuality: CGFloat) -> UIImage {
        return UIImage(data: self.jpegData(compressionQuality: compressionQuality)!)!
    }

    func compressBelow(rect: CGSize) -> UIImage {
        guard size.width > rect.width, size.height > rect.height else {
            return self
        }
        let resizeFactor = size.width > size.height ? size.width / rect.width : size.height / rect.height
        let canvasImageSize = CGSize(width: size.width / resizeFactor,
                                     height: size.height / resizeFactor)

        UIGraphicsBeginImageContextWithOptions(canvasImageSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasImageSize))

        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
