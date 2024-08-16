// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
public enum AccessibilityTrait {
    case largeText
    case extraLargeText
    case highContrast
    case lowAnimation
    case noAnimation
    case grayscale
    case darkMode
    case lowContrast
    case buttonTapArea
}
@available(iOS 17.0, macOS 14.0, tvOS 17.0, visionOS 1.0, watchOS 10.0, *)
@freestanding(declaration, names: named(Previews))
public macro Preview(trait: AccessibilityTrait, name: String? = nil, body: @escaping @MainActor () -> any View) = #externalMacro(module: "AccessiblePreviewMacros", type: "AccessibilityPreviewMacro")

@available(iOS 17.0, macOS 14.0, tvOS 17.0, visionOS 1.0, watchOS 10.0, *)
@freestanding(declaration, names: named(Previews))
public macro Preview(traits: AccessibilityTrait..., name: String? = nil, body: @escaping @MainActor () -> any View) = #externalMacro(module: "AccessiblePreviewMacros", type: "AccessibilityPreviewMacro")
