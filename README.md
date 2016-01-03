# InfiniteCollectionView

Infinite Scrolling Using `UICollectionView`

<img src="https://github.com/hryk224/InfiniteCollectionView/wiki/images/sample1.gif" width="320" >
<img src="https://github.com/hryk224/InfiniteCollectionView/wiki/images/sample2.gif" width="320" >

## Requirements
- iOS 8.0+
- Swift 2.0+
- ARC

## install

#### Cocoapods

Adding the following to your `Podfile` and running `pod install`:

```Ruby
use_frameworks!
pod "InfiniteCollectionView"
```

### import

```Swift
import InfiniteCollectionView
```

## Usage

#### initialize

```Swift
@IBOutlet weak var collectionView: InfiniteCollectionView!
```

#### delegate, dataSource

```Swift
collectionView.infiniteDataSource = self
collectionView.infiniteDelegate = self
collectionView.cellWidth = XXX
```

```Swift
// protocol
func cellForItemAtIndexPath(collectionView: UICollectionView, dequeueIndexPath: NSIndexPath, indexPath: NSIndexPath) -> UICollectionViewCell
func numberOfItems(collectionView: UICollectionView) -> Int

// optional
func didSelectCellAtIndexPath(collectionView: UICollectionView, indexPath: NSIndexPath)
func didUpdatePageIndex(index: Int)
```

## Photos from

* by [pakutaso.com](https://www.pakutaso.com/)

## License

This project is made available under the MIT license. See LICENSE file for details.
