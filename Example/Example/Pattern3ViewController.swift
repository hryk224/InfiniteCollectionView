//
//  Pattern3ViewController.swift
//  Example
//
//  Created by iamchiwon on 2018. 3. 8..
//  Copyright © 2018년 hiroyuki yoshida. All rights reserved.
//

import UIKit
import InfiniteCollectionView

final class Pattern3ViewController: UIViewController {
    var itemsCount: Int = 5
    @IBOutlet weak var collectionView: InfiniteCollectionView! {
        didSet {
            collectionView.infiniteDataSource = self
            collectionView.infiniteDelegate = self
            collectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        }
    }
    @IBOutlet weak var layout: UICollectionViewFlowLayout! {
        didSet {
            layout.itemSize = UIScreen.main.bounds.size
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(Pattern1ViewController.rotate(_:)), name: .UIDeviceOrientationDidChange, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIDeviceOrientationDidChange, object: nil)
    }
    static func createFromStoryboard() -> Pattern3ViewController {
        let storyboard = UIStoryboard(name: "Pattern3", bundle: nil)
        return storyboard.instantiateInitialViewController() as! Pattern3ViewController
    }
    @objc func rotate(_ notification: Notification) {
        layout.itemSize = UIScreen.main.bounds.size
        layout.invalidateLayout()
        collectionView.rotate(notification)
        collectionView.layoutIfNeeded()
        collectionView.setNeedsLayout()
    }
}

// MARK: - InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate
extension Pattern3ViewController: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    func number(ofItems collectionView: UICollectionView) -> Int {
        return itemsCount
    }
    func collectionView(_ collectionView: UICollectionView, dequeueForItemAt dequeueIndexPath: IndexPath, cellForItemAt usableIndexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: dequeueIndexPath) as! ImageCollectionViewCell
        cell.configure(indexPath: usableIndexPath)
        return cell
    }
    func infiniteCollectionView(_ collectionView: UICollectionView, didSelectItemAt usableIndexPath: IndexPath) {
        print("didSelectItemAt: \(usableIndexPath.item)")
    }
    func scrollView(_ scrollView: UIScrollView, pageIndex: Int) {
        print("scrollView: \(pageIndex)")
    }
}

