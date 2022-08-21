import Foundation
import TokamakDOM

/// A wrapper around another view that sets user-selectability for text.
struct UserSelectable<Content>: View where Content: View {
    let userSelectable: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        DynamicHTML(
            "div",
            ["style": "user-select: \(userSelectable)"]
        ) {
            content()
        }
    }
}

extension View {
    func userSelectable(_ userSelectable: String) -> UserSelectable<Self> {
        UserSelectable(userSelectable: userSelectable) { self }
    }

    func nonSelectable() -> UserSelectable<Self> {
        userSelectable("none")
    }
}
