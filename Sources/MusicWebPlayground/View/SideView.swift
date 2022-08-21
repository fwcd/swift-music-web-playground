import TokamakDOM

struct SideView: View {
    @EnvironmentObject private var audioManager: AudioManager
    @EnvironmentObject private var midiManager: MidiManager
    @EnvironmentObject private var pianoKeyboard: PianoKeyboardViewModel

    var body: some View {
        VStack(alignment: .leading) {
            StatusIndicatorView(active: audioManager.audioAvailable, label: "Audio available")
            StatusIndicatorView(active: midiManager.midiAvailable, label: "MIDI available")
            StatusIndicatorView(label: "\(midiManager.midiInputCount) MIDI input(s)")

            HStack {
                Button("<") {
                    pianoKeyboard.shiftOctaveRange(by: -1)
                }

                let octaveRange = pianoKeyboard.octaveRange
                Text("C\(octaveRange.lowerBound) to C\(octaveRange.upperBound)")

                Button(">") {
                    pianoKeyboard.shiftOctaveRange(by: 1)
                }
            }

            // TODO: Picker is broken currently, therefore we'll disable it until
            // https://github.com/TokamakUI/Tokamak/issues/285 is fixed
            // EnumPicker(selection: $audioManager.oscillatorType) {
            //     Text("Oscillator Type: ")
            // }
        }
    }
}
