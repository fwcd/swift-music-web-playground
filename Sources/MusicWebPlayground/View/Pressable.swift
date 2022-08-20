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
                "mousemove": { event in
                    if event.buttons == 1 {
                        // Left mouse button dragged within this element
                        onPressChanged(true, CGPoint(mouseEvent: event))
                    }
                },
                "mouseenter": { event in
                    if event.buttons == 1 {
                        // Left mouse button dragged into this element
                        onPressChanged(true, CGPoint(mouseEvent: event))
                    }
                },
                "mouseout": { event in
                    if event.buttons == 1 {
                        // Left mouse button dragged out of this element
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
