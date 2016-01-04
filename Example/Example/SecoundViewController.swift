//
//  SecoundViewController.swift
//  Example
//
//  Created by hiroyuki yoshida on 2016/01/04.
//  Copyright © 2016年 hiroyuki yoshida. All rights reserved.
//

import UIKit
import InfiniteCollectionView

final class SecoundViewController: UIViewController {
    
    static func createFromStoryboard() -> SecoundViewController {
        let storyboard = UIStoryboard(name: "Secound", bundle: nil)
        return storyboard.instantiateInitialViewController() as! SecoundViewController
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension SecoundViewController: UITableViewDataSource, UITableViewDelegate {
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
            let cell = tableView.dequeueReusableCellWithIdentifier(SecoundInfiniteTableViewCell.identifier) as! SecoundInfiniteTableViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(SecoundInfinite2TableViewCell.identifier) as! SecoundInfinite2TableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(SecoundTableViewCell.identifier)
            cell?.textLabel?.text = String(indexPath.row)
            return cell!
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

final class SecoundTableViewCell: UITableViewCell {
    static let identifier = "SecoundTableViewCell"
}

final class SecoundInfiniteTableViewCell: UITableViewCell {
    static let identifier = "SecoundInfiniteTableViewCell"
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
            layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 239)
        }
    }
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.numberOfPages = 10
        }
    }
}

// MARK: - InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate
extension SecoundInfiniteTableViewCell: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    func numberOfItems(collectionView: UICollectionView) -> Int {
        return 10
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

final class SecoundInfinite2TableViewCell: UITableViewCell {
    static let identifier = "SecoundInfinite2TableViewCell"
    @IBOutlet weak var collectionView: InfiniteCollectionView! {
        didSet {
            collectionView.infiniteDataSource = self
            collectionView.infiniteDelegate = self
            collectionView.cellWidth = 100
            collectionView.registerNib(IntroCollectionViewCell.nib, forCellWithReuseIdentifier: IntroCollectionViewCell.identifier)
        }
    }
    @IBOutlet weak var layout: UICollectionViewFlowLayout! {
        didSet {
            layout.scrollDirection = .Horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 10
            layout.itemSize = CGSize(width: 100, height: 100)
        }
    }
}

// MARK: - InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate
extension SecoundInfinite2TableViewCell: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    func numberOfItems(collectionView: UICollectionView) -> Int {
        return 10
    }
    func cellForItemAtIndexPath(collectionView: UICollectionView, dequeueIndexPath: NSIndexPath, indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(IntroCollectionViewCell.identifier, forIndexPath: dequeueIndexPath) as! IntroCollectionViewCell
        cell.configure(dequeueIndexPath: indexPath)
        return cell
    }
}








