//
//  SkateMapContainerViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 07. 08..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

private enum SegmentedControlState: Int {
    case map = 0
    case list = 1
}

class SkateMapContainerViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    weak var coordinator: SkateMapCoordinator?
    lazy var skateMapViewController = SkateMapViewController.instantiateViewController(from: .skateMap)
    lazy var skateListViewController = SkateListViewController.instantiateViewController(from: .skateMap)

    // MARK: Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        addChildViewControllers()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        configureNavigationBar()
        configureSegmentedControl()
    }

    private func configureNavigationBar() {
        navigationItem.title = Texts.SkateMap.mapNavBarTitle.localized
        navigationController?.navigationBar.barTintColor = Theme.Color.primaryTurquoise

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Theme.Icon.filteringEmpty,
            style: .done,
            target: self,
            action: #selector(toFilteringScreen))
    }

    private func configureSegmentedControl() {
        segmentedControl.setTitle(Texts.SkateMap.mapSegmentTitle.localized,
                                  forSegmentAt: SegmentedControlState.map.rawValue)
        segmentedControl.setTitle(Texts.SkateMap.listSegmentTitle.localized,
                                  forSegmentAt: SegmentedControlState.list.rawValue)
    }
}

// MARK: - Setup view
extension SkateMapContainerViewController {
    private func addChildViewControllers() {
        addSkateMapViewController()
    }

    private func addSkateMapViewController() {
        skateMapViewController.coordinator = coordinator
        add(skateMapViewController, to: containerView)
    }

    private func addSkateListViewController() {
        skateListViewController.coordinator = coordinator
        skateListViewController.dataSource.places = skateMapViewController.waypoints ?? []
        add(skateListViewController, to: containerView)
    }
}

// MARK: Actions
extension SkateMapContainerViewController {
    @IBAction func segmentedControlTap(_ sender: UISegmentedControl) {
        guard let selectedSegment = SegmentedControlState(rawValue: sender.selectedSegmentIndex) else { return }

        switch selectedSegment {
        case .map:
            addSkateMapViewController()
        case .list:
            addSkateListViewController()
        }
    }
}

// MARK: Navigation
extension SkateMapContainerViewController {
    @objc private func toFilteringScreen() {
        coordinator?.toFilteringScreen(using: self)
    }
}

// MARK: UIViewControllerTransitioningDelegate methods
extension SkateMapContainerViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return HalfScreenModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: PlaceFilterDelegate methods
extension SkateMapContainerViewController: PlaceFilterDelegate {
    func filterAnnotations(by selectedTypes: [WaypointType]) {
        changeFilteringIcon(isFiltered: WaypointType.allCases.count != selectedTypes.count)
        skateMapViewController.updateMapWaypoints()
    }

    private func changeFilteringIcon(isFiltered: Bool) {
        let buttonItem = navigationItem.rightBarButtonItem
        buttonItem?.image = isFiltered ? Theme.Icon.filteringFull : Theme.Icon.filteringEmpty
        navigationItem.rightBarButtonItem = buttonItem
    }
}
