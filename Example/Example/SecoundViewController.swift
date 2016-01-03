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
        } else {
            return 50
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(SecoundInfiniteTableViewCell.identifier) as! SecoundInfiniteTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(SecoundTableViewCell.identifier)
            cell?.textLabel?.text = String(indexPath.row)
            return cell!
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
        } else {
            return 50
        }
    }
}

final class SecoundTableViewCell: UITableViewCell {
    static let identifier = "SecoundTableViewCell"
}

final class SecoundInfiniteTableViewCell: UITableViewCell {
    static let identifier = "SecoundInfiniteTableViewCell"
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
            layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 159)
        }
    }
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.numberOfPages = items.count
        }
    }
}

// MARK: - InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate
extension SecoundInfiniteTableViewCell: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
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









