import OpenCombine
import JavaScriptKit

/// Handles interaction with the Web MIDI API.
class MidiManager: ObservableObject {
    @Published private(set) var midiAvailable: Bool = false
    @Published private(set) var midiInputCount: Int = 0

    init() {
        Task {
            do {
                try await initializeWebMidi()
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
        
        // TODO: Continuously monitor for inputs? Is that needed?
        _ = midiAccess.inputs.forEach(JSClosure { entry in
            _ = entry[0].addEventListener("midimessage", JSClosure { msg in
                print("Got MIDI message")
                return .undefined
            })
            return .undefined
        })

        midiAvailable = true
        midiInputCount = Int(midiAccess.inputs.size.number!)
    }
}
