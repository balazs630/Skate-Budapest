//
//  GPXParser.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 21..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import MapKit

class GPXParser: NSObject {
    // MARK: Properties
    typealias GPXCompletionHandler = (GPXParser?) -> Void
    private let completionHandler: GPXCompletionHandler
    private let url: URL
    private var inputStream = ""

    var waypoints = [Waypoint]()
    private var waypoint: Waypoint!
    private var image: PlaceImage?

    // MARK: Initializers
    private init(url: URL, completionHandler: @escaping GPXCompletionHandler) {
        self.url = url
        self.completionHandler = completionHandler
    }
}

// MARK: Utility methods
extension GPXParser {
    class func parse(url: URL, completionHandler: @escaping GPXCompletionHandler) {
        GPXParser(url: url, completionHandler: completionHandler).parse()
    }

    private func parse() {
        DispatchQueue.global(qos: .userInitiated).async {
            let parser = XMLParser(contentsOf: self.url)!
            parser.delegate = self

            return self.complete(success: parser.parse())
        }
    }

    private func complete(success: Bool) {
        DispatchQueue.main.async {
            self.completionHandler(success ? self : nil)
        }
    }
}

// MARK: XMLParserDelegate methods
extension GPXParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        inputStream += string
    }

    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName: String?,
                attributes attributeDict: [String: String]) {
        guard let elementType = GPX.Tag(rawValue: elementName) else { return }
        switch elementType {
        case .waypoint:
            let latitude = Double(attributeDict[GPX.Tag.latitude.rawValue]!)!
            let longitude = Double(attributeDict[GPX.Tag.longitude.rawValue]!)!
            waypoint = Waypoint(latitude: latitude, longitude: longitude)
        case .image:
            image = PlaceImage(href: attributeDict[GPX.Tag.href.rawValue]!)
        default:
            break
        }
    }

    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName: String?) {
        guard let elementType = GPX.Tag(rawValue: elementName) else { return }
        switch elementType {
        case .waypoint:
            waypoints.append(waypoint)
        case .name, .description, .locationType:
            waypoint!.attributes[elementName] = inputStream.trimmed
            inputStream = ""
        case .image:
            if let image = image {
                waypoint.images.append(image)
            }
        case .imageType:
            if let image = image {
                image.imageAttributes[elementName] = inputStream.trimmed
                inputStream = ""
            }
        default:
            break
        }
    }
}
