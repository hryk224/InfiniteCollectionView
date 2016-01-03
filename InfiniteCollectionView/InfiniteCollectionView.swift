//
//  Bottomsheet.swift
//  Pods
//
//  Created by hiroyuki yoshida on 2015/10/17.
//
//

import UIKit

public protocol InfiniteCollectionViewDataSource: class {
    func cellForItemAtIndexPath(collectionView: UICollectionView, dequeueIndexPath: NSIndexPath, indexPath: NSIndexPath) -> UICollectionViewCell
    func numberOfItems(collectionView: UICollectionView) -> Int
}

@objc public protocol InfiniteCollectionViewDelegate: class {
    optional func didSelectCellAtIndexPath(collectionView: UICollectionView, indexPath: NSIndexPath)
    optional func didUpdatePageIndex(index: Int)
}

public class InfiniteCollectionView: UICollectionView {
    private typealias Me = InfiniteCollectionView
    private static let dummyCount: Int = 3
    private static let defaultIdentifier = "Cell"
    public weak var infiniteDataSource: InfiniteCollectionViewDataSource?
    public weak var infiniteDelegate: InfiniteCollectionViewDelegate?
    public var cellWidth: CGFloat = UIScreen.mainScreen().bounds.width
    private var indexOffset: Int = 0
    private var currentIndex: Int = 0
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
}

// MARK: - private
private extension InfiniteCollectionView {
    func configure() {
        backgroundColor = UIColor.clearColor()
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        clipsToBounds = true
        scrollEnabled = true
        pagingEnabled = true
        delegate = self
        dataSource = self
        registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: Me.defaultIdentifier)
    }
    
    func centerIfNeeded(scrollView: UIScrollView) {
        let currentOffset = contentOffset
        let contentWidth = totalContentWidth()
        // Calculate the centre of content X position offset and the current distance from that centre point
        let centerOffsetX: CGFloat = (CGFloat(Me.dummyCount) * contentWidth - bounds.size.width) / 2
        let distFromCentre = centerOffsetX - currentOffset.x
        if fabs(distFromCentre) > (contentWidth / 4) {
            // Total cells (including partial cells) from centre
            let cellcount = distFromCentre / cellWidth
            // Amount of cells to shift (whole number) - conditional statement due to nature of +ve or -ve cellcount
            let shiftCells = Int((cellcount > 0) ? floor(cellcount) : ceil(cellcount))
            // Amount left over to correct for
            let offsetCorrection = (abs(cellcount) % 1) * cellWidth
            // Scroll back to the centre of the view, offset by the correction to ensure it's not noticable
            if centerOffsetX > contentOffset.x {
                //left scrolling
                contentOffset = CGPoint(x: centerOffsetX - offsetCorrection, y: currentOffset.y)
            } else if contentOffset.x > centerOffsetX {
                //right scrolling
                contentOffset = CGPoint(x: centerOffsetX + offsetCorrection, y: currentOffset.y)
            }
            // Make content shift as per shiftCells
            shiftContentArray(correctedIndex(shiftCells))
            reloadData()
        }
        let centerPoint = CGPoint(x: scrollView.frame.size.width / 2 + scrollView.contentOffset.x, y: scrollView.frame.size.height / 2 + scrollView.contentOffset.y)
        guard let indexPath = indexPathForItemAtPoint(centerPoint) else { return }
        infiniteDelegate?.didUpdatePageIndex?(correctedIndex(indexPath.row - indexOffset))
    }
    func shiftContentArray(offset: Int) {
        indexOffset += offset
    }
    func totalContentWidth() -> CGFloat {
        let numberOfCells = infiniteDataSource?.numberOfItems(self) ?? 0
        return CGFloat(numberOfCells) * cellWidth
    }
    func correctedIndex(indexToCorrect: Int) -> Int {
        if let numberOfItems = infiniteDataSource?.numberOfItems(self) {
            if numberOfItems > indexToCorrect && indexToCorrect >= 0 {
                return indexToCorrect
            } else {
                let countInIndex = Float(indexToCorrect) / Float(numberOfItems)
                let flooredValue = Int(floor(countInIndex))
                let offset = numberOfItems * flooredValue
                return indexToCorrect - offset
            }
        } else {
            return 0
        }
    }
}

// MARK: - UICollectionViewDataSource
extension InfiniteCollectionView: UICollectionViewDataSource {
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = infiniteDataSource?.numberOfItems(self) ?? 0
        return Me.dummyCount * numberOfItems
    }
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var maybeCell: UICollectionViewCell!
        maybeCell = infiniteDataSource?.cellForItemAtIndexPath(self, dequeueIndexPath: indexPath, indexPath: NSIndexPath(forRow: correctedIndex(indexPath.row - indexOffset), inSection: 0))
        if maybeCell == nil {
            maybeCell = collectionView.dequeueReusableCellWithReuseIdentifier(Me.defaultIdentifier, forIndexPath: indexPath)
        }
        return maybeCell
    }
}

// MARK: - UICollectionViewDelegate
extension InfiniteCollectionView: UICollectionViewDelegate {
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        infiniteDelegate?.didSelectCellAtIndexPath?(self, indexPath: NSIndexPath(forRow: correctedIndex(indexPath.row - indexOffset), inSection: 0))
    }
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        centerIfNeeded(scrollView)
    }
}
