import Foundation
import TokamakDOM

struct Positioned<Content>: View where Content: View {
    let position: CGPoint
    @ViewBuilder let content: () -> Content

    var body: some View {
        DynamicHTML(
            "div",
            ["style": "position: relative; top: \(position.y)px; left: \(position.x)px;"]
        ) {
            content()
        }
    }
}

extension View {
    func positioned(at position: CGPoint) -> Positioned<Self> {
        Positioned(position: position) { self }
    }
}
