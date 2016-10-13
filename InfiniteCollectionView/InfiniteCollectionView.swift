//
//  InfiniteCollectionView.swift
//  Pods
//
//  Created by hryk224 on 2015/10/17.
//
//

import UIKit

public protocol InfiniteCollectionViewDataSource: class {
    func number(ofItems collectionView: UICollectionView) -> Int
    func collectionView(_ collectionView: UICollectionView, dequeueForItemAt dequeueIndexPath: IndexPath, cellForItemAt usableIndexPath: IndexPath) -> UICollectionViewCell
}

@objc public protocol InfiniteCollectionViewDelegate: class {
    @objc optional func infiniteCollectionView(_ collectionView: UICollectionView, didSelectItemAt usableIndexPath: IndexPath)
    @objc optional func scrollView(_ scrollView: UIScrollView, pageIndex: Int)
}

open class InfiniteCollectionView: UICollectionView {
    fileprivate typealias Me = InfiniteCollectionView
    fileprivate static let dummyCount: Int = 3
    fileprivate static let defaultIdentifier = "Cell"
    open weak var infiniteDataSource: InfiniteCollectionViewDataSource?
    open weak var infiniteDelegate: InfiniteCollectionViewDelegate?
    open var cellWidth: CGFloat = UIScreen.main.bounds.width
    fileprivate var indexOffset: Int = 0
    fileprivate var currentIndex: Int = 0
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
}

// MARK: - private
private extension InfiniteCollectionView {
    func configure() {
        delegate = self
        dataSource = self
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: Me.defaultIdentifier)
    }
    
    func centerIfNeeded(_ scrollView: UIScrollView) {
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
            let offsetCorrection = (abs(cellcount).truncatingRemainder(dividingBy: 1)) * cellWidth
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
        guard let indexPath = indexPathForItem(at: centerPoint) else { return }
        infiniteDelegate?.scrollView?(scrollView, pageIndex: correctedIndex(indexPath.item - indexOffset))
    }
    func shiftContentArray(_ offset: Int) {
        indexOffset += offset
    }
    func totalContentWidth() -> CGFloat {
        let numberOfCells = infiniteDataSource?.number(ofItems: self) ?? 0
        return CGFloat(numberOfCells) * cellWidth
    }
    func correctedIndex(_ indexToCorrect: Int) -> Int {
        if let numberOfItems = infiniteDataSource?.number(ofItems: self) {
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
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = infiniteDataSource?.number(ofItems: collectionView) ?? 0
        return Me.dummyCount * numberOfItems
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var maybeCell: UICollectionViewCell!
        maybeCell = infiniteDataSource?.collectionView(collectionView, dequeueForItemAt: indexPath, cellForItemAt: IndexPath(row: correctedIndex(indexPath.item - indexOffset), section: 0))
        if maybeCell == nil {
            maybeCell = collectionView.dequeueReusableCell(withReuseIdentifier: Me.defaultIdentifier, for: indexPath)
        }
        return maybeCell
    }
}

// MARK: - UICollectionViewDelegate
extension InfiniteCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        infiniteDelegate?.infiniteCollectionView?(collectionView, didSelectItemAt: IndexPath(row: correctedIndex(indexPath.item - indexOffset), section: 0))
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        centerIfNeeded(scrollView)
    }
}
