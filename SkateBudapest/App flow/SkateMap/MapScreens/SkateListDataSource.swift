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
    public var places: [PlaceDisplayItem]

    // MARK: Initializers
    init(places: [PlaceDisplayItem]) {
        self.places = places
    }
}

// MARK: - UITableViewDataSource
extension SkateListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: SkateListCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SkateListCell else {
            fatalError("SkateListCell cannot be found")
        }

        cell.displayItem = places[indexPath.row]

        return cell
    }
}
