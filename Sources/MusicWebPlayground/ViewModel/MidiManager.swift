import OpenCombine

/// Handles interaction with the Web MIDI API.
class MidiManager: ObservableObject {
    @Published var midiAvailable: Bool = false
}
