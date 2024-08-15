import AccessiblePreview
import SwiftUI


struct ContentView: View {
    var body: some View {
        Text("olá")
    }
}

struct XView: View {
    var body: some View {
        Group {
            ContentView()
                .previewDisplayName("name Default")
            
            ContentView()
                .previewDisplayName("name Text Size - Accessibility XXXL")
            
            ContentView()
                .previewDisplayName("name High Contrast")
            
            ContentView()
                .previewDisplayName("name Text Size XXXL & High Contrast")
        }
    }
}


