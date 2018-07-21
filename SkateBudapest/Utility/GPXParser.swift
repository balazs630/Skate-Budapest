//
//  GPXParser.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 21..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import MapKit

class GPXParser: NSObject, XMLParserDelegate {
    // MARK: Properties
    typealias GPXCompletionHandler = (GPXParser?) -> Void
    private let completionHandler: GPXCompletionHandler
    private let url: URL
    private var inputStream = ""

    private var waypoint: Waypoint?
    private var track: Track?
    private var link: Link?

    var waypoints = [Waypoint]()
    var tracks = [Track]()
    var routes = [Track]()

    // MARK: Initializers
    private init(url: URL, completionHandler: @escaping GPXCompletionHandler) {
        self.url = url
        self.completionHandler = completionHandler
    }
}

// MARK: XML parser utility methods
extension GPXParser {
    private func complete(success: Bool) {
        DispatchQueue.main.async {
            self.completionHandler(success ? self : nil)
        }
    }

    class func parse(url: URL, completionHandler: @escaping GPXCompletionHandler) {
        GPXParser(url: url, completionHandler: completionHandler).parse()
    }

    private func parse() {
        DispatchQueue.global(qos: .userInitiated).async {
            let parser = XMLParser(contentsOf: self.url)!
            parser.delegate = self

            parser.shouldProcessNamespaces = false
            parser.shouldReportNamespacePrefixes = false
            parser.shouldResolveExternalEntities = false

            return self.complete(success: parser.parse())
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        inputStream += string
    }

    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName: String?,
                attributes attributeDict: [String: String]) {
        switch elementName {
        case "trkseg":
            if track == nil { fallthrough }
        case "trk":
            tracks.append(Track())
            track = tracks.last
        case "rte":
            routes.append(Track())
            track = routes.last
        case "rtept", "trkpt", "wpt":
            let latitude = Double(attributeDict["lat"]!)!
            let longitude = Double(attributeDict["lon"]!)!
            waypoint = Waypoint(latitude: latitude, longitude: longitude)
        case "link":
            link = Link(href: attributeDict["href"]!)
        default:
            break
        }
    }

    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName: String?) {
        switch elementName {
        case "wpt":
            if waypoint != nil {
                waypoints.append(waypoint!)
                waypoint = nil
            }
        case "trkpt", "rtept":
            if waypoint != nil {
                track?.fixes.append(waypoint!)
                waypoint = nil
            }
        case "trk", "trkseg", "rte":
            track = nil
        case "link":
            if link != nil {
                if waypoint != nil {
                    waypoint!.links.append(link!)
                } else if track != nil {
                    track!.links.append(link!)
                }
            }
            link = nil
        default:
            if link != nil {
                link!.linkAttributes[elementName] = inputStream.trimmed
            } else if waypoint != nil {
                waypoint!.attributes[elementName] = inputStream.trimmed
            } else if track != nil {
                track!.attributes[elementName] = inputStream.trimmed
            }

            inputStream = ""
        }
    }
}
