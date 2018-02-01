# KTSnackBar

[![CI Status](http://img.shields.io/travis/KoH1011/KTSnackBar.svg?style=flat)](https://travis-ci.org/KoH1011/KTSnackBar)
[![Version](https://img.shields.io/cocoapods/v/KTSnackBar.svg?style=flat)](http://cocoapods.org/pods/KTSnackBar)
[![License](https://img.shields.io/cocoapods/l/KTSnackBar.svg?style=flat)](http://cocoapods.org/pods/KTSnackBar)
[![Platform](https://img.shields.io/cocoapods/p/KTSnackBar.svg?style=flat)](http://cocoapods.org/pods/KTSnackBar)

![](https://github.com/KoH1011/KTSnackBar/blob/master/ScreenShots/Screenshot.gif)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Simple

```swift
self.snackBar = KTSnackBar()
self.snackBar.show(buttonText: "Tap Dissmiss!")
self.setupEnabled(for: false)
self.snackBar.pressedBlock = {
  print("Dismiss!")
}
```

### Custom

```swift
let view = UIView()
view.backgroundColor = UIColor.red
view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20)
let option = [
    .height(20)
    ] as [KTSnackBarOption]
self.snackBar = KTSnackBar(options: option, showHandler: {
    print("custom show")
}) {
    print("custom dismiss")
}
snackBar.show(aView: view)
```

## Requirements
- iOS 9.0+
- Swift 4

## Installation

### CocoaPods (iOS 9+)
KTSnackBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
use_frameworks!
pod "KTSnackBar"
```

### Carthage (iOS 9+)
You can use [Carthage](https://github.com/Carthage/Carthage) to install `KTSnackBar` by adding it to your `Cartfile`:
```ruby
github "KoH1011/KTSnackBar"
```

### Manual Installation
The class file required for Popover is located in the Classes folder in the root of this repository as listed below:
```
KTSnackBar.swift
```

## Customization

### Enum
- ``case width(CGFloat)``
- ``case height(CGFloat)``
- ``case font(UIFont)``
- ``case interval(Double)``

## License

KTSnackBar is available under the MIT license. See the LICENSE file for more info.
