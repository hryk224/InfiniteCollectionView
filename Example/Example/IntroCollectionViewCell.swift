//
//  IntroCollectionViewCell.swift
//  Example
//
//  Created by hiroyuki yoshida on 2016/01/04.
//  Copyright © 2016年 hiroyuki yoshida. All rights reserved.
//

import UIKit

final class IntroCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    static let identifier = "IntroCollectionViewCell"
    static let nib = UINib(nibName: "IntroCollectionViewCell", bundle: nil)
    func configure(dequeueIndexPath dequeueIndexPath: NSIndexPath) {
        let image = UIImage(named: String(dequeueIndexPath.row))
        imageView.image = image
        setNeedsLayout()
        layoutIfNeeded()
    }
}
