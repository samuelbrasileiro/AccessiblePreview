import SwiftCompilerPlugin
import SwiftUI
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

enum Message: DiagnosticMessage {
    case expectedAView
    case nameShouldBeString
    case invalidTrait
    
    var message: String {
        switch self {
        case .expectedAView: "Expected a view inside the macro."
        case .nameShouldBeString: "Expected name to be a String."
        case .invalidTrait: "This trait is unimplemented."
        }
    }
    
    var diagnosticID: SwiftDiagnostics.MessageID {
        switch self {
        case .expectedAView: .init(domain: "AccessibilityPreviews", id: "expected-a-view")
        case .nameShouldBeString: .init(domain: "AccessibilityPreviews", id: "name-should-be-string")
        case .invalidTrait: .init(domain: "AccessibilityPreviews", id: "invalid-trait")
        }
    }
    
    var severity: SwiftDiagnostics.DiagnosticSeverity {
        switch self {
        case .expectedAView, .nameShouldBeString, .invalidTrait: .error
        }
    }
    
    func diagnostic(from node: SyntaxProtocol) -> Diagnostic {
        .init(node: node, message: self)
    }
    
}

public struct AccessibilityPreviewMacro: DeclarationMacro {
    static var count: Int = 0

    public static func expansion(
        of macro: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let arguments = macro.arguments
        let allArguments = arguments.compactMap { $0.expression }
        let nameArgument = arguments.dropFirst().first?.expression
        let viewArgument = arguments.dropFirst(2).first?.expression

        let traitStrings = allArguments.compactMap { $0.as(MemberAccessExprSyntax.self)?.declName.description }
        let traits = traitStrings.compactMap { AccessibilityTrait(rawValue: $0) }
        guard let firstTrait = traits.first else {
            throw DiagnosticsError(diagnostics: [Message.invalidTrait.diagnostic(from: macro)])
        }

        guard let view = (viewArgument?.as(ClosureExprSyntax.self) ?? macro.trailingClosure)?
            .statements else {
            throw DiagnosticsError(diagnostics: [Message.expectedAView.diagnostic(from: macro)])
        }
        let previewName = nameArgument?.as(StringLiteralExprSyntax.self)?.representedLiteralValue
        let name = if let previewName {
            "\(previewName) - \(firstTrait.name)"
        } else {
            firstTrait.name
        }
        
        let allTraitsText = traits.reduce(into: String()) { text, trait in
            text += "                \(trait.modifiers)\n"
        }
        let providerName = previewName ?? "default"
        let previewProvider: DeclSyntax = """
        struct \(raw: context.makeUniqueName(providerName)): DeveloperToolsSupport.PreviewRegistry {
            static var fileID: String {
                \(context.location(of: macro)?.file)
            }
            static var line: Int {
                \(context.location(of: macro)?.line)
            }
            static var column: Int {
                \(raw: arguments.count)
            }

            static func makePreview() throws -> DeveloperToolsSupport.Preview {
                DeveloperToolsSupport.Preview("\(raw: name)") {
                    \(view)
        \(raw: allTraitsText)
                }
            }
        }
        
        """
        
        count += 1
        return [DeclSyntax(previewProvider)]
    }
}

enum AccessibilityTrait: String {
    case largeText
    case extraLargeText
    case highContrast
    case lowAnimation
    case noAnimation
    case grayscale
    case darkMode
    case lowContrast
    case buttonTapArea
    
    var name: String {
        switch self {
        case .largeText: "Large text"
        case .extraLargeText:
            "Extra Large Text"
        case .highContrast:
            "High Contrast"
        case .lowAnimation:
            "Low Animation"
        case .noAnimation:
            "No Animation"
        case .grayscale: "Grayscale"
        case .darkMode: "Dark Mode"
        case .lowContrast: "Low Contrast"
        case .buttonTapArea: "Inspect Buttons View"
        }
    }
    
    var modifiers: String {
        switch self {
        case .largeText:
            """
            .dynamicTypeSize(.xxxLarge)
            .bold()
            """
        case .extraLargeText:
            """
            .dynamicTypeSize(.accessibility5)
            .bold()
            """
        case .highContrast:
            """
            .contrast(3)
            """
        case .lowAnimation:
            """
            .animation(
                .easeIn.speed(0.2).repeatForever(
                    autoreverses: true
                )
            )
            """
        case .noAnimation:
            """
            .animation(
                .easeIn.speed(0).repeatForever(
                    autoreverses: true
                )
            )
            """
        case .grayscale:
            """
            .grayscale(1)
            """
        case .darkMode:
            """
            .preferredColorScheme(.dark)
            """
        case .lowContrast:
            """
            .contrast(0.4)
            """
        case .buttonTapArea:
            """
            .buttonStyle(_AccessibleButton())
            """
        }
    }
}

@main
struct AccessiblePreviewPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        AccessibilityPreviewMacro.self,
    ]
}
