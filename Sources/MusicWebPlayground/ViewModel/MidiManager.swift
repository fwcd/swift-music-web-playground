import OpenCombine
import JavaScriptKit

/// Handles interaction with the Web MIDI API.
class MidiManager: ObservableObject {
    @Published var midiAvailable: Bool = false

    init() {
        Task {
            do {
                try await initializeWebMidi()
                midiAvailable = true
            } catch MidiError.midiUnavailable {
                print("Web MIDI is unavailable")
            } catch {
                print("Could not initialize Web MIDI: \(error)")
            }
        }
    }

    private func initializeWebMidi() async throws {
        let navigator = JSObject.global.navigator
        guard navigator.requestMIDIAccess.function != nil,
              let midiPromise = navigator.requestMIDIAccess(navigator).object,
              let midiAccess = try await JSPromise(midiPromise)?.value else {
            throw MidiError.midiUnavailable
        }
        print("MIDI access: \(midiAccess)")
    }
}
