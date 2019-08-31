//
//  ImageViewerViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 19..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

protocol ImageViewerViewControllerDelegate: class {
    func updateImageOffset(indexPath: IndexPath)
}

class ImageViewerViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    var images: [UIImage]!
    var imageOffset: IndexPath!
    weak var delegate: ImageViewerViewControllerDelegate?

    // MARK: Outlets
    @IBOutlet weak var imageCollectionView: UICollectionView!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateCollectionViewLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageCollectionView.scrollToItem(at: imageOffset, at: .left, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.updateImageOffset(indexPath: imageOffset)
    }

    // MARK: Screen configuration
    private func configureSelf() {
        configureCollectionView()
    }

    private func configureCollectionView() {
        imageCollectionView.accessibilityIdentifier = AccessibilityID.PlaceDetails.imageViewer
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
    }

    private func updateCollectionViewLayout() {
        guard let flowLayout = imageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.itemSize = imageCollectionView.frame.size
        flowLayout.invalidateLayout()
    }
}

// MARK: UICollectionViewDataSource methods
extension ImageViewerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.imageViewerCellIdentifier,
                                                                for: indexPath)
                as? ImagePreviewFullViewCell else { fatalError("Unable to cast cell as ImagePreviewFullViewCell") }
            cell.display(image: images[indexPath.row])
            return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentScrollIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        imageOffset.row = currentScrollIndex
    }
}

// MARK: UICollectionViewDelegate
extension ImageViewerViewController: UICollectionViewDelegate { }
