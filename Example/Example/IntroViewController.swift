//
//  IntroViewController.swift
//  Example
//
//  Created by hiroyuki yoshida on 2016/01/04.
//  Copyright © 2016年 hiroyuki yoshida. All rights reserved.
//

import UIKit
import InfiniteCollectionView

final class IntroViewController: UIViewController {
    var items = ["1", "2", "3", "4"]
    @IBOutlet weak var collectionView: InfiniteCollectionView! {
        didSet {
            collectionView.infiniteDataSource = self
            collectionView.infiniteDelegate = self
            collectionView.cellWidth = UIScreen.mainScreen().bounds.width
            collectionView.registerNib(IntroCollectionViewCell.nib, forCellWithReuseIdentifier: IntroCollectionViewCell.identifier)
            collectionView.pagingEnabled = true
        }
    }
    @IBOutlet weak var layout: UICollectionViewFlowLayout! {
        didSet {
            layout.scrollDirection = .Horizontal
            layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        }
    }
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.numberOfPages = items.count
        }
    }
    static func createFromStoryboard() -> IntroViewController {
        let storyboard = UIStoryboard(name: "Intro", bundle: nil)
        return storyboard.instantiateInitialViewController() as! IntroViewController
    }
}

// MARK: - InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate
extension IntroViewController: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    func numberOfItems(collectionView: UICollectionView) -> Int {
        return items.count
    }
    func cellForItemAtIndexPath(collectionView: UICollectionView, dequeueIndexPath: NSIndexPath, indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(IntroCollectionViewCell.identifier, forIndexPath: dequeueIndexPath) as! IntroCollectionViewCell
        cell.configure(dequeueIndexPath: indexPath)
        return cell
    }
    func didSelectCellAtIndexPath(collectionView: UICollectionView, indexPath: NSIndexPath) {
    }
    func didUpdatePageIndex(index: Int) {
        pageControl.currentPage = index
    }
}
