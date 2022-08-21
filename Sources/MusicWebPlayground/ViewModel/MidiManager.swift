import OpenCombine
import JavaScriptKit

/// Handles interaction with the Web MIDI API.
class MidiManager: ObservableObject {
    @Published private(set) var midiAvailable: Bool = false
    @Published private(set) var midiInputCount: Int = 0
    @Published private(set) var activeMidiNotes: Set<Int> = []

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
            _ = entry[0].addEventListener("midimessage", JSClosure { [self] msg in
                // TODO: Move parsing to a dedicated library
                let buffer = msg[0].data.object!
                let midiMsg = MidiMessage(
                    status: UInt8(buffer[0].number!),
                    data1: UInt8(buffer[1].number!),
                    data2: UInt8(buffer[2].number!)
                )
                print("Got \(midiMsg) (kind: \(midiMsg.statusKind.map { "\($0)".split(separator: ".").last! } ?? "?"))")
                switch midiMsg.statusKind {
                case .noteOn:
                    activeMidiNotes.insert(Int(midiMsg.data1))
                case .noteOff:
                    activeMidiNotes.remove(Int(midiMsg.data1))
                default:
                    break
                }
                return .undefined
            })
            return .undefined
        })

        midiAvailable = true
        midiInputCount = Int(midiAccess.inputs.size.number!)
    }
}
