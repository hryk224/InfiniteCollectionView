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
    enum Pattern: Int, CustomStringConvertible {
        case pattern1
        case pattern2
        static var count: Int { return 2 }
        var description: String {
            switch self {
            case .pattern1: return "pattern1"
            case .pattern2: return "pattern2"
            }
        }
    }
    fileprivate let identifier = "tableViewCell"
    fileprivate var cellHeight: CGFloat {
        return (UIScreen.main.bounds.height - 64) / CGFloat(Pattern.count)
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = cellHeight
            tableView.estimatedRowHeight = cellHeight
            tableView.separatorInset = .zero
            tableView.layoutMargins = .zero
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
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
        return Pattern.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        let pattern = Pattern(rawValue: indexPath.row)
        cell.textLabel?.text = pattern?.description
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pattern = Pattern(rawValue: indexPath.row) else { return }
        switch pattern {
        case .pattern1:
            let controller = Pattern1ViewController.createFromStoryboard()
            navigationController?.pushViewController(controller, animated: true)
        case .pattern2:
            let controller = Pattern2ViewController.createFromStoryboard()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
