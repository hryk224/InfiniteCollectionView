# InfiniteCollectionView

Infinite horizontal scrolling using `UICollectionView`

[![CocoaPods Compatible](http://img.shields.io/cocoapods/v/InfiniteCollectionView.svg?style=flat)](http://cocoadocs.org/docsets/InfiniteCollectionView)
[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/)

<img src="https://github.com/hryk224/InfiniteCollectionView/wiki/images/sample1.gif" width="320" >

<img src="https://github.com/hryk224/InfiniteCollectionView/wiki/images/sample2.gif" width="320" >

## Requirements
- iOS 8.0+
- Swift 3.0+
- ARC

## install

#### CocoaPods

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
collectionView.infiniteDataSource = XXX
collectionView.infiniteDelegate = XXX
```

```Swift
// protocol
func number(ofItems collectionView: UICollectionView) -> Int
func collectionView(_ collectionView: UICollectionView, dequeueForItemAt dequeueIndexPath: IndexPath, cellForItemAt usableIndexPath: IndexPath) -> UICollectionViewCell

// optional
func infiniteCollectionView(_ collectionView: UICollectionView, didSelectItemAt usableIndexPath: IndexPath)
func scrollView(_ scrollView: UIScrollView, pageIndex: Int)
```

## Photos from

* by [pakutaso.com](https://www.pakutaso.com/)

## License

This project is made available under the MIT license. See LICENSE file for details.
