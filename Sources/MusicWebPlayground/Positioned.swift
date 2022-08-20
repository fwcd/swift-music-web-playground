import Foundation
import TokamakDOM

struct Positioned<Content>: View where Content: View {
    let position: CGPoint
    var zIndex: Int = 0
    @ViewBuilder let content: () -> Content

    var body: some View {
        DynamicHTML(
            "div",
            ["style": "position: relative; top: \(position.y)px; left: \(position.x)px; z-index: \(zIndex);"]
        ) {
            content()
        }
    }
}

extension View {
    func positioned(at position: CGPoint, zIndex: Int = 0) -> Positioned<Self> {
        Positioned(position: position, zIndex: zIndex) { self }
    }
}
