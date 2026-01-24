# Maple

[![CI](https://github.com/mabeple/Maple/actions/workflows/CI.yml/badge.svg)](https://github.com/mabeple/Maple/actions/workflows/CI.yml)
[![codecov](https://codecov.io/gh/Mabeple/Maple/branch/master/graph/badge.svg)](https://codecov.io/gh/Mabeple/Maple)
[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS-lightgrey.svg)](https://github.com/Mabeple/Maple)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Native Swift extensions for iOS and macOS development.

## Features

- 🚀 **Foundation Extensions** - Date, Calendar, URL, Bundle, Data, Decimal
- 🎨 **UIKit Extensions** - UIImage, UIView, UIColor, UITableView, UICollectionView, etc.
- 💻 **AppKit Extensions** - macOS specific extensions
- 🌈 **SwiftUI Extensions** - Color extensions with dynamic color support
- 📐 **CoreGraphics Extensions** - CGPoint, CGRect, CGSize, CGFloat
- 🔧 **Swift Standard Library** - Array, Dictionary, String, Int, Double, etc.
- 📦 **Protocol** - NibLoadable for easy XIB/Storyboard loading
- ⚙️ **Runtime** - Runtime utilities

## Requirements

- iOS 15.0+ / macOS 12.0+
- Swift 6.0+
- Xcode 16.0+

## Installation

### Swift Package Manager

Add Maple to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Mabeple/Maple.git", from: "1.3.5")
]
```

Or add it through Xcode:
1. File > Add Package Dependencies
2. Enter: `https://github.com/Mabeple/Maple.git`

### CocoaPods

Add to your `Podfile`:

```ruby
pod 'Maple'
```

Then run:
```bash
pod install
```

## Usage

Import Maple in your Swift file:

```swift
import Maple
```

### Examples

#### Date Extensions
```swift
let date = Date()
date.mp.isToday // Check if date is today
date.mp.year    // Get year component
date.mp.adding(.day, value: 7) // Add 7 days
```

#### UIImage Extensions
```swift
let image = UIImage(color: .red, size: CGSize(width: 100, height: 100))
let fixedImage = image.mp.fixOrientation()
let rounded = image.mp.withRoundedCorners(radius: 10)
```

#### SwiftUI Color Extensions
```swift
import SwiftUI

let color = Color(hex: "#FF6432")
let dynamicColor = Color(light: .white, dark: .black)
let hexString = color.mp.hexString
```

#### Array Extensions
```swift
let array = [1, 2, 3, 4, 5]
let chunked = array.mp.chunked(into: 2) // [[1, 2], [3, 4], [5]]
let unique = [1, 2, 2, 3].mp.unique     // [1, 2, 3]
```

## Documentation

Full documentation is available at: https://mabeple.github.io/Maple/

Or generate locally:
```bash
make docs
```

## Development

### Build & Test
```bash
# Run tests
make test

# Generate documentation
make docs

# Preview documentation
make preview

# Generate code coverage
make coverage

# Clean build artifacts
make clean
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

Maple is available under the MIT license. See the [LICENSE](LICENSE) file for more info.


