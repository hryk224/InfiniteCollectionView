//
//  MainViewController.swift
//  Example
//
//  Created by hiroyuki yoshida on 2015/10/17.
//  Copyright © 2015年 hiroyuki yoshida. All rights reserved.
//

import UIKit
import InfiniteCollectionView

final class MainViewController: UIViewController {
    var patterns = ["pattern1", "pattern2"]
    let identifier = "tableViewCell"
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
            tableView.rowHeight = 100
            tableView.estimatedRowHeight = 100
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patterns.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        cell.textLabel?.text = patterns[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let controller = Pattern1ViewController.createFromStoryboard()
            navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 1 {
            let controller = Pattern2ViewController.createFromStoryboard()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
