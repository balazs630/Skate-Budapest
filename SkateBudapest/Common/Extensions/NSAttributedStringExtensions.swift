//
//  NSAttributedStringExtensions.swift
//  SkateBudapest
//
//  Created by Balázs Horváth on 2020. 08. 02..
//  Copyright © 2020. Horváth Balázs. All rights reserved.
//

import UIKit

extension NSAttributedString {
    convenience init(htmlString: String, font: UIFont) throws {
        let attributedString = try NSMutableAttributedString(
            data: Data(htmlString.utf8),
            options: [
                .documentType: DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        )

        let range = NSRange(location: 0, length: attributedString.length)

        attributedString.enumerateAttribute(.font, in: range) { value, range, _ in
            guard let currentFont = value as? UIFont,
               let newFontDescriptor = font.fontDescriptor.withSymbolicTraits(currentFont.fontDescriptor.symbolicTraits)
                else { return }

            attributedString.addAttribute(
                .font,
                value: UIFont(descriptor: newFontDescriptor, size: 0),
                range: range
            )
        }

        self.init(attributedString: attributedString)
    }
}

extension NSMutableAttributedString {
    public func addFullRangeAttributes(_ attrs: [NSAttributedString.Key: Any] = [:]) {
        addAttributes(attrs, range: NSRange(location: 0, length: length))
    }
}
