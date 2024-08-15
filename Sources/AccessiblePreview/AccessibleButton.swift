import SwiftUI


public struct _AccessibleButton: PrimitiveButtonStyle {
    @State private var sheetContentSize: CGSize?
    
    private var isOverBounds: Bool {
        isWidthOverBounds || isHeightOverBounds
    }
    
    private var isWidthOverBounds: Bool {
        self.sheetContentSize?.width ?? 0 < 44
    }
    
    private var isHeightOverBounds: Bool {
        self.sheetContentSize?.height ?? 0 < 44
    }
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            if isOverBounds {
                print(
                    "O botão não segue requisitos de acessibilidade: Ele possui \(Int(self.sheetContentSize?.width ?? 0)) de largura e \(Int(self.sheetContentSize?.height ?? 0)) de altura. Use largura e altura mínimos de 44px."
                )
            }
            else {
                print(
                    "O botão respeita o tamanho mínimo! Ele possui \(Int(self.sheetContentSize?.width ?? 0)) de largura e \(Int(self.sheetContentSize?.height ?? 0)) de altura."
                )
            }
            configuration.trigger()
        }) {
            ZStack(alignment: .top) {
                ZStack(alignment: .trailing) {
                    configuration.label
                        .background {
                            GeometryReader { proxy in
                                Color.clear
                                    .task { @MainActor in
                                        self.sheetContentSize = proxy.size
                                    }
                            }
                        }
                        .overlay(
                            Rectangle()
                                .stroke(isOverBounds ? .red : .green, lineWidth: 3)
                        )
                    Text("\(Int(sheetContentSize?.height ?? 0)) px")
                        .font(.caption)
                        .foregroundColor(isHeightOverBounds ? .red : .green)
                        .background(.black)
                        .offset(x: 20)
                }
                Text("\(Int(sheetContentSize?.width ?? 0)) px")
                    .font(.caption)
                    .foregroundColor(isWidthOverBounds ? .red : .green)
                    .background(.black)
                    .offset(y: -8)
            }
        }
    }
}
