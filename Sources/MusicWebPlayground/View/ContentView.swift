import TokamakDOM

/// The main content view of the app.
struct ContentView: View {
    var body: some View {
        HStack(spacing: 20) {
            PianoKeyboardView()
                .frame(width: 1000, height: 200) // TODO: Dynamic height?
            SideView()
                .nonSelectable()
        }
    }
}
