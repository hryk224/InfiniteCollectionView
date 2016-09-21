//
//  ImageCollectionViewCell.swift
//  Example
//
//  Created by hiroyuki yoshida on 2016/01/04.
//  Copyright © 2016年 hiroyuki yoshida. All rights reserved.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    static let identifier = "ImageCollectionViewCell"
    static let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    func configure(dequeueIndexPath: IndexPath) {
        let image = UIImage(named: String(dequeueIndexPath.item))
        imageView.image = image
        setNeedsLayout()
        layoutIfNeeded()
    }
}
