//
//  UIImageViewExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 19..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

extension Array where Element == UIImageView {
    func images() -> [UIImage] {
        var images = [UIImage]()
        self.forEach { imageView in
            images.append(imageView.image!)
        }
        return images
    }
}
