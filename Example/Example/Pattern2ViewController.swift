//
//  Pattern2ViewController.swift
//  Example
//
//  Created by hiroyuki yoshida on 2016/01/04.
//  Copyright © 2016年 hiroyuki yoshida. All rights reserved.
//

import UIKit
import InfiniteCollectionView

final class Pattern2ViewController: UIViewController {
    
    static func createFromStoryboard() -> Pattern2ViewController {
        let storyboard = UIStoryboard(name: "Pattern2", bundle: nil)
        return storyboard.instantiateInitialViewController() as! Pattern2ViewController
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .None
        }
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension Pattern2ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(InfiniteTableViewCell.identifier) as! InfiniteTableViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(Infinite2TableViewCell.identifier) as! Infinite2TableViewCell
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 240
        } else if indexPath.section == 1 {
            return 120
        }
        return 0
    }
}

final class InfiniteTableViewCell: UITableViewCell {
    static let identifier = "InfiniteTableViewCell"
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
            layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 239)
        }
    }
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.numberOfPages = 4
        }
    }
}

// MARK: - InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate
extension InfiniteTableViewCell: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    func numberOfItems(collectionView: UICollectionView) -> Int {
        return 4
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

final class Infinite2TableViewCell: UITableViewCell {
    static let identifier = "Infinite2TableViewCell"
    @IBOutlet weak var collectionView: InfiniteCollectionView! {
        didSet {
            collectionView.infiniteDataSource = self
            collectionView.infiniteDelegate = self
            collectionView.cellWidth = 100
            collectionView.registerNib(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        }
    }
}

// MARK: - InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate
extension Infinite2TableViewCell: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    func numberOfItems(collectionView: UICollectionView) -> Int {
        return 10
    }
    func cellForItemAtIndexPath(collectionView: UICollectionView, dequeueIndexPath: NSIndexPath, indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.identifier, forIndexPath: dequeueIndexPath) as! ImageCollectionViewCell
        cell.configure(dequeueIndexPath: indexPath)
        return cell
    }
}








