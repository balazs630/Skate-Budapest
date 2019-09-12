//
//  AccessibilityIDs.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 08. 31..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

struct AccessibilityID {
    struct SkateMap {
        static let mapTabBar = "skatemap.map.tab.bar"
        static let submitTabBar = "skatemap.submit.tab.bar"

        static let mapSegmentControl = "skatemap.map.segment.control"
        static let mapLayerButton = "skatemap.map.layer.button"
        static let mapLocationButton = "skatemap.map.location.button"
        static let mapWaypointPin = "skatemap.map.waypoint.pin"

        static let listTableView = "skatemap.list.tableView"
        static let listCellContainerView = "skatemap.list.cell.container.view"
        static let listCellTitleLabel = "skatemap.list.cell.title.label"
        static let listCellDescriptionLabel = "skatemap.list.cell.description.label"
        static let listCallThumbnailImage = "skatemap.list.cell.thumbnail.image"
    }

    struct Filter {
        static let navBarButton = "skatemap.filter.nav.bar.button"
        static let titleLabel = "skatemap.filter.title.label"
        static let skateshopLabel = "skatemap.filter.skateshop.label"
        static let skateshopSwitch = "skatemap.filter.skateshop.switch"
        static let streetspotLabel = "skatemap.filter.streetspot.label"
        static let streetspotSwitch = "skatemap.filter.streetspot.switch"
        static let skateparkLabel = "skatemap.filter.skatepark.label"
        static let skateparkSwitch = "skatemap.filter.skatepark.switch"
        static let actionButton = "skatemap.filter.action.button"
    }

    struct PlaceDetails {
        static let titleLabel = "skatemap.detail.title.label"
        static let categoryView = "skatemap.detail.category.view"
        static let categoryLabel = "skatemap.detail.category.label"
        static let descriptionLabel = "skatemap.detail.description.label"
        static let enableLocationLabel = "skatemap.detail.enable.location.label"
        static let enableLocationButton = "skatemap.detail.enable.location.button"
        static let image = "skatemap.detail.image"
        static let imageStepper = "skatemap.detail.image.stepper"
        static let imageViewer = "skatemap.detail.image.viewer"
    }

    struct SubmitPlace {
    }
}
