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
            tableView.separatorStyle = .none
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension Pattern2ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1: return 1
        default: return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfiniteTableViewCell.identifier) as! InfiniteTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Infinite2TableViewCell.identifier) as! Infinite2TableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 240
        case 1: return 120
        default: return 0
        }
    }
}

final class InfiniteTableViewCell: UITableViewCell {
    static let identifier = "InfiniteTableViewCell"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(InfiniteTableViewCell.rotate(_:)), name: .UIDeviceOrientationDidChange, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIDeviceOrientationDidChange, object: nil)
    }
    @IBOutlet weak var collectionView: InfiniteCollectionView! {
        didSet {
            collectionView.infiniteDataSource = self
            collectionView.infiniteDelegate = self
            collectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        }
    }
    @IBOutlet weak var layout: UICollectionViewFlowLayout! {
        didSet {
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 239)
        }
    }
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.numberOfPages = 4
        }
    }
    @objc func rotate(_ notification: Notification) {
        let size = CGSize(width: UIScreen.main.bounds.width, height: 239)
        layout.itemSize = size
        layout.invalidateLayout()
        collectionView.rotate(notification)
        collectionView.layoutIfNeeded()
        collectionView.setNeedsLayout()
    }
}

// MARK: - InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate
extension InfiniteTableViewCell: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    func number(ofItems collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, dequeueForItemAt dequeueIndexPath: IndexPath, cellForItemAt usableIndexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: dequeueIndexPath) as! ImageCollectionViewCell
        cell.configure(indexPath: usableIndexPath)
        return cell
    }
    func scrollView(_ scrollView: UIScrollView, pageIndex: Int) {
        pageControl.currentPage = pageIndex
    }
}

final class Infinite2TableViewCell: UITableViewCell {
    static let identifier = "Infinite2TableViewCell"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(Infinite2TableViewCell.rotate(_:)), name: .UIDeviceOrientationDidChange, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIDeviceOrientationDidChange, object: nil)
    }
    @IBOutlet weak var collectionView: InfiniteCollectionView! {
        didSet {
            collectionView.infiniteDataSource = self
            collectionView.infiniteDelegate = self
            collectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        }
    }
}

// MARK: - InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate
extension Infinite2TableViewCell: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    func number(ofItems collectionView: UICollectionView) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, dequeueForItemAt dequeueIndexPath: IndexPath, cellForItemAt usableIndexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: dequeueIndexPath) as! ImageCollectionViewCell
        cell.configure(indexPath: usableIndexPath)
        return cell
    }
    func infiniteCollectionView(_ collectionView: UICollectionView, didSelectItemAt usableIndexPath: IndexPath) {
        print("didSelectItemAt: \(usableIndexPath.item)")
    }
    @objc func rotate(_ notification: Notification) {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.rotate(notification)
        collectionView.layoutIfNeeded()
        collectionView.setNeedsLayout()
    }
}
