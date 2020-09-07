//
//  SkateListDataSource.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 07. 08..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SkateListDataSource: NSObject {
    // MARK: Properties
    private let placeFilterController = PlaceFilterController()
    public var places: [PlaceDisplayItem]

    // MARK: Initializers
    init(places: [PlaceDisplayItem]) {
        self.places = places
    }

    // MARK: Utility
    private func filteredPlaces() -> [PlaceDisplayItem] {
        return places.filter { placeFilterController.isSelected(type: $0.type) }
    }
}

// MARK: - UITableViewDataSource
extension SkateListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPlaces().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: SkateListCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SkateListCell else {
            fatalError("SkateListCell cannot be found")
        }

        cell.displayItem = filteredPlaces()[indexPath.row]

        return cell
    }
}
