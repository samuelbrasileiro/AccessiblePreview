# AccessiblePreview

[![Swift Version](https://img.shields.io/badge/Swift-5.10-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2016.0%2B%20%7C%20macOS%2012.0%2B-lightgrey.svg)](https://developer.apple.com/documentation/xcode/creating_a_mac_app)
[![License](https://img.shields.io/github/license/samuelbrasileiro/AccessiblePreview)](https://github.com/samuelbrasileiro/AccessiblePreview/blob/main/LICENSE)

`AccessiblePreview` is a Swift package designed to streamline the process of creating accessibility-friendly interfaces in SwiftUI. By leveraging this package, developers can easily generate previews that simulate various accessibility settings directly within Xcode, ensuring their applications are inclusive and accessible to all users.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Getting Started](#getting-started)
  - [Supported Accessibility Traits](#supported-accessibility-traits)
  - [Example Usages](#example-usages)
- [Practical Use Cases](#practical-use-cases)
- [Advanced Customization](#advanced-customization)
- [License](#license)

## Overview

Accessibility is a fundamental aspect of user interface design, especially in mobile applications. `AccessiblePreview` simplifies the task of previewing and testing accessibility settings in SwiftUI views by introducing a macro that integrates seamlessly into your development workflow. Whether you're designing for dynamic text sizes, high contrast, or other accessibility features, this package helps you visualize how your interface will behave under different conditions, reducing the risk of accessibility issues reaching production.

## Installation

### Swift Package Manager

To add `AccessiblePreview` to your project:

1. In Xcode, navigate to `File > Swift Packages > Add Package Dependency`.
2. Enter the repository URL: `https://github.com/samuelbrasileiro/AccessiblePreview.git`.
3. Select the version you need, then integrate the package into your project.

Alternatively, add the following line to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/samuelbrasileiro/AccessiblePreview.git", from: "1.0.0")
]
```

## Getting Started

`AccessiblePreview` provides a straightforward way to simulate various accessibility settings in your SwiftUI previews. This enables you to catch potential issues early in the development process.

### Supported Accessibility Traits

The macro `#Preview` supports a variety of accessibility traits, including:

- **No Animation (`.noAnimation`)**: Disables animations to check for UI functionality without transitions.
- **High Contrast (`.highContrast`)**: Applies a high-contrast color scheme to ensure text and controls remain legible.
- **Dynamic Text (`.extraLargeText`)**: Simulates different text sizes, including the largest accessibility sizes.
- **Dark Mode (`.darkMode`)**: Previews the UI in dark mode to ensure proper color and contrast handling.
- **Button Tap Area Limitations (`.buttonTapArea`)**: Tests how touch target areas is affecting your UI.

### Example Usages

Here are some practical examples of how to use `AccessiblePreview` in your project:

```swift
import SwiftUI
import AccessiblePreview

struct ContentView: View {
    @State var buttonOffset = 0.0
    var body: some View {
        Text("Hello, World!")
            .padding()
        Button("Here's a button") {
            buttonOffset += 10
        }
        .offset(y: buttonOffset)
    }
}

// Example 1: Preview with slower animations
#Preview(trait: .lowAnimation) {
    AnimatedContentView()
}

// Example 2: High contrast with extra-large dynamic text
#Preview(traits: .highContrast, .extraLargeText) {
    ContentView()
}

// Example 3: Preview in dark mode
#Preview(trait: .darkMode) {
    ContentView()
}

// Example 4: Preview with detailed button tap area, showing if it respects minimal 44x44px limit
#Preview(trait: .buttonTapArea, name: "Accessibility") {
    ContentView()
}
```

### Behavior

When you use the `#Preview` macro, the specified traits are applied to the provided view, creating a preview that reflects those accessibility conditions. This enables you to see how your UI responds under various scenarios, all within the familiar Xcode environment.

## Practical Use Cases

### Accessibility Testing During Development

With `AccessiblePreview`, you can efficiently test how your app’s UI adapts to different accessibility settings without having to constantly switch your device’s configurations. This not only saves time but also helps ensure that your app is accessible to a broader audience.

### Identifying and Fixing UI Issues

Using specific previews for scenarios like high contrast or increased text sizes, you can easily spot issues such as clipped text, poor color contrast, or inadequately sized touch targets, allowing you to address these problems early in the development cycle.

### Continuous UI Improvement

By integrating `AccessiblePreview` into your development process, you can iterate on your UI designs with the confidence that each iteration will be tested against the same set of accessibility standards, leading to a more polished and inclusive final product.

## Advanced Customization

While `AccessiblePreview` comes with a robust set of built-in accessibility traits, it also supports advanced customization to fit the specific needs of your project.

```swift
#Preview(traits: .highContrast, .extraLargeText, .darkMode, name: "Custom Preview") {
    CustomContentView()
}
```

This example shows how you can combine multiple traits into a single preview and name it for better clarity.

## License

`AccessiblePreview` is released under the MIT License, making it free to use in both personal and commercial projects. For more details, refer to the [LICENSE](LICENSE) file.
