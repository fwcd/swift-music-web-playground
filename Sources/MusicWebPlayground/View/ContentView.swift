import TokamakDOM

struct ContentView: View {
    var body: some View {
        PianoKeyboardView()
            .frame(width: 1000, height: 200) // TODO: Dynamic height?
    }
}
