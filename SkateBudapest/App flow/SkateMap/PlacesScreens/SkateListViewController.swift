//
//  SkateListViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 07. 08..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SkateListViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    weak var coordinator: SkateMapCoordinator?
    var dataSource = SkateListDataSource(places: [])

    // MARK: Outlets
    @IBOutlet weak var placesTableView: UITableView!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent != nil {
            updateListWaypoints()
        }
    }

    // MARK: Screen configuration
    private func configureSelf() {
        placesTableView.delegate = self
        placesTableView.dataSource = dataSource
    }
}

// MARK: Waypoint operations
extension SkateListViewController {
    func updateListWaypoints() {
        guard let tableview = placesTableView else { return }
        tableview.reloadData()
    }
}

// MARK: Navigation
extension SkateListViewController {
    private func navigatoToDetails(displayItem: PlaceDisplayItem) {
        coordinator?.toPlaceDetailsScreen(place: displayItem)
    }
}

// MARK: UITableViewDelegate methods
extension SkateListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigatoToDetails(displayItem: dataSource.places[indexPath.row])
    }
}
