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
    var cellHeight: CGFloat {
        return (UIScreen.main.bounds.height - 64) / CGFloat(patterns.count)
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
            tableView.rowHeight = cellHeight
            tableView.estimatedRowHeight = cellHeight
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        tableView.deselectRow(at: selectedIndexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patterns.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        cell.textLabel?.text = patterns[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let controller = Pattern1ViewController.createFromStoryboard()
            navigationController?.pushViewController(controller, animated: true)
        case 1:
            let controller = Pattern2ViewController.createFromStoryboard()
            navigationController?.pushViewController(controller, animated: true)
        default:
            break
        }
    }
}
