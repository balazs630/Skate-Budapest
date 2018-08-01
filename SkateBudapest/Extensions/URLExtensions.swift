//
//  URLExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 05..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

extension Array where Element == URL? {
    func imagesFromURLs() -> [UIImage] {
        var images = [UIImage]()

        self.forEach { url in
            if let url = url,
                let imageData = NSData(contentsOf: url),
                let image = UIImage(data: imageData as Data) {
                images.append(image)
            }
        }

        return images
    }
}
