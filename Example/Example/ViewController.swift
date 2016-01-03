//
//  ViewController.swift
//  Example
//
//  Created by hiroyuki yoshida on 2015/10/17.
//  Copyright © 2015年 hiroyuki yoshida. All rights reserved.
//

import UIKit
import InfiniteCollectionView

final class ViewController: UIViewController {
    var patterns = ["pattern1", "pattern2"]
    let identifier = "tableViewCell"
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: identifier)
            tableView.rowHeight = 100
            tableView.estimatedRowHeight = 100
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patterns.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier)!
        cell.textLabel?.text = patterns[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let controller = IntroViewController.createFromStoryboard()
            navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 1 {
            let controller = SecoundViewController.createFromStoryboard()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}