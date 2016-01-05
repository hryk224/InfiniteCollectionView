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
    var items = ["1", "2", "3", "4"]
    @IBOutlet weak var collectionView: InfiniteCollectionView! {
        didSet {
            collectionView.infiniteDataSource = self
            collectionView.infiniteDelegate = self
            collectionView.cellWidth = UIScreen.mainScreen().bounds.width
            collectionView.registerNib(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        }
    }
    @IBOutlet weak var layout: UICollectionViewFlowLayout! {
        didSet {
            layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        }
    }
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.numberOfPages = items.count
        }
    }
    static func createFromStoryboard() -> Pattern1ViewController {
        let storyboard = UIStoryboard(name: "Pattern1", bundle: nil)
        return storyboard.instantiateInitialViewController() as! Pattern1ViewController
    }
}

// MARK: - InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate
extension Pattern1ViewController: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    func numberOfItems(collectionView: UICollectionView) -> Int {
        return items.count
    }
    func cellForItemAtIndexPath(collectionView: UICollectionView, dequeueIndexPath: NSIndexPath, indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.identifier, forIndexPath: dequeueIndexPath) as! ImageCollectionViewCell
        cell.configure(dequeueIndexPath: indexPath)
        return cell
    }
    func didSelectCellAtIndexPath(collectionView: UICollectionView, indexPath: NSIndexPath) {
    }
    func didUpdatePageIndex(index: Int) {
        pageControl.currentPage = index
    }
}
