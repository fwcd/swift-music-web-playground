import TokamakDOM

struct SideView: View {
    @EnvironmentObject private var midiManager: MidiManager

    var body: some View {
        VStack(alignment: .leading) {
            StatusIndicatorView(active: midiManager.midiAvailable, label: "MIDI available")
            StatusIndicatorView(label: "\(midiManager.midiInputCount) MIDI input(s)")
        }
    }
}
