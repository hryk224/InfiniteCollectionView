# InfiniteCollectionView

Component which presents a dismissible view from the bottom of the screen

<img src="https://github.com/hryk224/InfiniteCollectionView/wiki/images/sample1.gif" width="320" >

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

```Swift
let controller = InfiniteCollectionView.Controller()

// Adds Toolbar
controller.addToolbar({ toolbar in
    // toolbar
})

// Adds View
let view = UIView
controller.addContentsView(view)

// Adds NavigationBar
controller.addNavigationbar(configurationHandler: { navigationBar in
    // navigationBar
})

// Adds CollectionView
controller.addCollectionView(configurationHandler: { [weak self] collectionView in
    // collectionView
})

// Adds TableView
controller.addTableView(configurationHandler: { [weak self] tableView in
    // tableView
})

// customize
controller.overlayBackgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.3)
controller.viewActionType = .TappedDismiss
controller.initializeHeight = 200
```

##License

This project is made available under the MIT license. See LICENSE file for details.
