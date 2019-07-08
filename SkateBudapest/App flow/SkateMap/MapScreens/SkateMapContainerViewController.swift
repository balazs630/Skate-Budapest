//
//  SkateMapContainerViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 07. 08..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

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
}

// MARK: - Setup view
extension SkateMapContainerViewController {
    private func addChildViewControllers() {
        skateMapViewController.coordinator = coordinator
        add(skateMapViewController, to: containerView)
    }
}

// MARK: Actions
extension SkateMapContainerViewController {
    @IBAction func segmentedControlTap(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            add(skateMapViewController, to: containerView)
        case 1:
            add(skateListViewController, to: containerView)
        default:
            break
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
        return skateMapViewController.filter(by: selectedTypes)
    }

    private func changeFilteringIcon(isFiltered: Bool) {
        let buttonItem = navigationItem.rightBarButtonItem
        buttonItem?.image = isFiltered ? Theme.Icon.filteringFull : Theme.Icon.filteringEmpty
        navigationItem.rightBarButtonItem = buttonItem
    }
}
