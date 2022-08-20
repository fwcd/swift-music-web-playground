import TokamakDOM

struct Pressable<Content>: View where Content: View {
    @ViewBuilder let content: () -> Content
    var onPressChanged: (Bool) -> Void = { _ in }

    var body: some View {
        DynamicHTML(
            "div",
            listeners: [
                "mousedown": { _ in onPressChanged(true) },
                "mouseup": { _ in onPressChanged(false) },
                "mouseenter": { event in
                    if event.buttons == 1 {
                        // Left mouse button held
                        onPressChanged(true)
                    }
                },
                "mouseout": { event in
                    if event.buttons == 1 {
                        // Left mouse button held
                        onPressChanged(false)
                    }
                },
            ]
        ) {
            content()
        }
    }
}
