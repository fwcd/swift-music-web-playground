import TokamakDOM

/// The main content view of the app.
struct ContentView: View {
    var body: some View {
        PianoKeyboardView()
            .frame(width: 1000, height: 200) // TODO: Dynamic height?
    }
}
