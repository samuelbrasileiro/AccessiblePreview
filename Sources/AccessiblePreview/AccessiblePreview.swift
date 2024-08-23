// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

/// An enumeration representing various accessibility traits that can be applied to a SwiftUI view preview.
/// These traits simulate different accessibility settings, enabling developers to ensure their UI is accessible
/// and usable under diverse conditions.
///
/// ## Discussion
/// Accessibility is a critical aspect of modern app development. By simulating different accessibility settings,
/// developers can preview and optimize their UI for users with different needs, such as those requiring larger text,
/// higher contrast, or reduced motion. Using `AccessibilityTrait`, developers can create previews that
/// expose potential usability issues, ensuring the app is inclusive and user-friendly for everyone.
public enum AccessibilityTrait {
    
    /// Simulates a larger text size, increasing the text size slightly to ensure readability.
    ///
    /// ## Example
    /// ```swift
    /// #Preview(trait: .largeText) {
    ///     ContentView()
    /// }
    /// ```
    /// This will generate a preview where the text size is increased.
    case largeText
    
    /// Simulates an extra-large text size, often used for accessibility.
    /// This is especially important for users who rely on larger text settings in their device's accessibility options.
    ///
    /// ## Example
    /// ```swift
    /// #Preview(trait: .extraLargeText) {
    ///     ContentView()
    /// }
    /// ```
    /// This preview will apply an even larger text size, allowing you to test UI behavior under extreme conditions.
    case extraLargeText
    
    /// Simulates a high contrast environment, which enhances the contrast between UI elements.
    /// This trait is essential for users with visual impairments who need clear distinctions between elements.
    ///
    /// ## Discussion
    /// High contrast modes can reveal issues with color choices in the UI, such as insufficient contrast between text
    /// and background. Testing with this trait ensures that all content is visible and readable in high contrast settings.
    ///
    /// ## Example
    /// ```swift
    /// #Preview(trait: .highContrast) {
    ///     ContentView()
    /// }
    /// ```
    /// This preview will show the UI with high contrast enabled.
    case highContrast
    
    /// Simulates a low animation environment, where animations are reduced to avoid triggering motion sensitivity.
    ///
    /// ## Discussion
    /// Users with motion sensitivity may prefer or require reduced motion settings. Testing your UI with reduced animations
    /// ensures that the app remains usable and comfortable for these users.
    ///
    /// ## Example
    /// ```swift
    /// #Preview(trait: .lowAnimation) {
    ///     ContentView()
    /// }
    /// ```
    /// This will preview your UI with reduced animations.
    case lowAnimation
    
    /// Simulates an environment with no animations at all, ensuring UI functionality without transitions.
    ///
    /// ## Example
    /// ```swift
    /// #Preview(trait: .noAnimation) {
    ///     ContentView()
    /// }
    /// ```
    /// Use this trait to check that the UI remains functional and visually coherent even with all animations disabled.
    case noAnimation
    
    /// Simulates a grayscale environment, where all UI elements are displayed in shades of gray.
    ///
    /// ## Discussion
    /// Grayscale mode is important for users with color vision deficiencies. Testing your UI in grayscale helps ensure
    /// that color alone isn't being used to convey important information, thereby making the app accessible to all users.
    ///
    /// ## Example
    /// ```swift
    /// #Preview(trait: .grayscale) {
    ///     ContentView()
    /// }
    /// ```
    /// This preview will render the UI in grayscale.
    case grayscale
    
    /// Simulates dark mode, where the UI uses darker colors for backgrounds and lighter colors for text.
    ///
    /// ## Discussion
    /// Dark mode is not only a preference for many users, but also an accessibility feature for those who find bright screens
    /// uncomfortable. Ensure that your UI adapts gracefully to dark mode by testing with this trait.
    ///
    /// ## Example
    /// ```swift
    /// #Preview(trait: .darkMode) {
    ///     ContentView()
    /// }
    /// ```
    /// This will generate a preview of your UI in dark mode.
    case darkMode
    
    /// Simulates a low contrast environment, reducing the contrast between UI elements.
    ///
    /// ## Discussion
    /// Low contrast testing is crucial for ensuring that your UI remains readable even in scenarios where contrast is minimized,
    /// such as when users have specific visual impairments or when the device is used in challenging lighting conditions.
    ///
    /// ## Example
    /// ```swift
    /// #Preview(trait: .lowContrast) {
    ///     ContentView()
    /// }
    /// ```
    /// This will show the UI with reduced contrast.
    case lowContrast
    
    /// Highlights and details the button tap area, encouraging to make interactive areas larger and easier to tap.
    ///
    /// ## Discussion
    /// This trait is particularly useful for users with motor impairments or those who find it difficult to precisely tap small buttons.
    /// Testing with this trait helps ensure that your app is accessible and comfortable for all users.
    ///
    /// ## Example
    /// ```swift
    /// #Preview(trait: .buttonTapArea) {
    ///     ContentView()
    /// }
    /// ```
    /// This preview will highlight the buttons and explain for easier tapping.
    case buttonTapArea
}

/// A SwiftUI preview with a single accessibility trait.
/// It allows you to preview a SwiftUI view under a specific accessibility condition, making it easier to identify
/// and address potential usability issues related to that condition.
///
/// ## Discussion
/// The `Preview` macro is a powerful tool for developers aiming to create inclusive and accessible apps. By applying a specific
/// `AccessibilityTrait`, you can simulate the conditions experienced by users with different accessibility needs. 
///
/// This focused approach allows you to test how your UI adapts to a particular setting, ensuring that your app is functional,
/// readable, and comfortable to use under various conditions.
///
/// - Parameters:
///   - trait: The `AccessibilityTrait` to be applied to the preview.
///   - name: An optional name for the preview, useful for identification in Xcode.
///   - body: A closure that returns the SwiftUI view to be previewed.
///
/// ## Example
/// ```swift
/// #Preview(trait: .highContrast) {
///     ContentView()
/// }
/// ```
/// This will generate a high contrast preview of `ContentView`, helping you ensure that the UI is clear and legible for users
/// who require or prefer high contrast settings.
@available(iOS 17.0, macOS 14.0, tvOS 17.0, visionOS 1.0, watchOS 10.0, *)
@freestanding(declaration, names: named(Previews))
public macro Preview(trait: AccessibilityTrait, name: String? = nil, body: @escaping @MainActor () -> any View) = #externalMacro(module: "AccessiblePreviewMacros", type: "AccessibilityPreviewMacro")

/// A SwiftUI preview with multiple accessibility traits.
/// It allows you to preview a SwiftUI view under several accessibility conditions simultaneously.
///
/// It's particularly useful for testing complex scenarios where multiple accessibility settings might interact,
/// ensuring that your UI remains functional and user-friendly under diverse conditions.
///
/// ## Discussion
/// When multiple accessibility traits are applied, it's essential to ensure that they don't conflict with each other or
/// degrade the user experience. The `Preview` macro with multiple traits allows you to simulate and test such scenarios.
/// By testing multiple traits at once, you can catch issues that might not be evident when testing traits individually.
///
/// - Parameters:
///   - traits: A variadic list of `AccessibilityTrait` to be applied to the preview.
///   - name: An optional name for the preview, useful for identification in Xcode.
///   - body: A closure that returns the SwiftUI view to be previewed.
///
/// ## Example
/// ```swift
/// #Preview(traits: .darkMode, .extraLargeText) {
///     ContentView()
/// }
/// ```
///
/// This will generate a preview where `ContentView` is displayed in dark mode with extra-large text,
/// helping you ensure that the UI remains clear and navigable in these combined conditions.
@available(iOS 17.0, macOS 14.0, tvOS 17.0, visionOS 1.0, watchOS 10.0, *)
@freestanding(declaration, names: named(Previews))
public macro Preview(traits: AccessibilityTrait..., name: String? = nil, body: @escaping @MainActor () -> any View) = #externalMacro(module: "AccessiblePreviewMacros", type: "AccessibilityPreviewMacro")
