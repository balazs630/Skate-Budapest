//
//  SkateListViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 07. 08..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SkateListViewController: UIViewController {
    // MARK: Properties
    private let placeCachingService = PlaceCachingService()
    private var emptyScreen: EmptyDataViewController?
    weak var coordinator: SkateMapCoordinator?
    var dataSource = SkateListDataSource(places: [])

    // MARK: Outlets
    @IBOutlet private weak var placesTableView: UITableView!

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
        configureTableview()
    }

    private func configureTableview() {
        placesTableView.delegate = self
        placesTableView.dataSource = dataSource

        if dataSource.places.isEmpty {
            showEmptyDataView()
        }

        placesTableView.accessibilityIdentifier = AccessibilityID.SkateMap.listTableView
    }

    // MARK: Empty data screen
    private func showEmptyDataView() {
        emptyScreen = EmptyDataViewController(
            title: Texts.SkateMap.emptyListTitle.localized,
            action: { [weak self] in
                self?.reloadPlaces()
        })
        placesTableView.backgroundView = emptyScreen?.view
        placesTableView.separatorStyle = .none
    }

    private func removeEmptyDataView() {
        emptyScreen = nil
        placesTableView.backgroundView = nil
        placesTableView.separatorStyle = .singleLine
    }

    private func reloadPlaces() {
        placeCachingService.getPlaces() { [weak self] result in
            guard let `self` = self else { return }

            if case .success(let places) = result {
                self.dataSource.places = places
                self.updateListWaypoints()
                self.removeEmptyDataView()
            }
        }
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
