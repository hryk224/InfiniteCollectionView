//
//  Pattern1ViewController.swift
//  Example
//
//  Created by hiroyuki yoshida on 2016/01/04.
//  Copyright © 2016年 hiroyuki yoshida. All rights reserved.
//

import UIKit
import InfiniteCollectionView

final class Pattern1ViewController: UIViewController {
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
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.numberOfPages = itemsCount
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(Pattern1ViewController.rotate(_:)), name: .UIDeviceOrientationDidChange, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIDeviceOrientationDidChange, object: nil)
    }
    static func createFromStoryboard() -> Pattern1ViewController {
        let storyboard = UIStoryboard(name: "Pattern1", bundle: nil)
        return storyboard.instantiateInitialViewController() as! Pattern1ViewController
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
extension Pattern1ViewController: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
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
        pageControl.currentPage = pageIndex
    }
}
