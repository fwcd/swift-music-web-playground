import TokamakDOM

/// The main content view of the app.
struct ContentView: View {
    @EnvironmentObject private var midiManager: MidiManager

    var body: some View {
        HStack(spacing: 20) {
            PianoKeyboardView()
                .frame(width: 1000, height: 200) // TODO: Dynamic height?
            VStack(alignment: .leading) {
                StatusIndicatorView(active: midiManager.midiAvailable, label: "MIDI available")
                StatusIndicatorView(label: "\(midiManager.midiInputCount) MIDI input(s)")
            }
        }
    }
}
