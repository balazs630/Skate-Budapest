//
//  ImageService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 15..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

enum ImageType {
    case thumbnail
    case gallery
}

class ImageService {
    static func imageData(from imageUrl: String?, imageType: ImageType) -> Data {
        guard let imageUrl = imageUrl,
            let url = URL(string: imageUrl),
            let imageData = try? Data(contentsOf: url) else {
                return placeholderImage(for: imageType)
        }

        return imageData
    }

    static func placeholderImage(for type: ImageType) -> Data {
        switch type {
        case .thumbnail:
            guard let placeholder = Theme.Image.placeholderSquare.jpegData(compressionQuality: 1.0) else {
                return Data()
            }
            return placeholder
        case .gallery:
            return Data()
        }
    }
}
