import Foundation
import TokamakDOM

struct Pressable<Content>: View where Content: View {
    @ViewBuilder let content: () -> Content
    var onPressChanged: (Bool, CGPoint) -> Void = { _, _ in }

    var body: some View {
        DynamicHTML(
            "div",
            listeners: [
                "mousedown": { event in
                    onPressChanged(true, CGPoint(mouseEvent: event))
                },
                "mouseup": { event in
                    onPressChanged(false, CGPoint(mouseEvent: event))
                },
                "mouseenter": { event in
                    if event.buttons == 1 {
                        // Left mouse button held
                        onPressChanged(true, CGPoint(mouseEvent: event))
                    }
                },
                "mouseout": { event in
                    if event.buttons == 1 {
                        // Left mouse button held
                        onPressChanged(false, CGPoint(mouseEvent: event))
                    }
                },
            ]
        ) {
            content()
        }
    }
}

extension View {
    func pressable(onPressChanged: @escaping (Bool, CGPoint) -> Void) -> Pressable<Self> {
        Pressable(content: { self }, onPressChanged: onPressChanged)
    }
}
