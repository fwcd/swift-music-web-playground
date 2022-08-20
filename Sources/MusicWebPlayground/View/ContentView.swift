import TokamakDOM

struct ContentView: View {
    var body: some View {
        PianoKeyboardView()
            .frame(width: 1000, height: 400) // TODO: Dynamic height?
    }
}
