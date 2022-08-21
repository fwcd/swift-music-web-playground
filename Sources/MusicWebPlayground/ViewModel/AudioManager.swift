import OpenCombine
import JavaScriptKit

/// Handles interaction with the Web Audio API.
class AudioManager: ObservableObject {
    @Published private(set) var audioAvailable: Bool = false

    init() {
        do {
            try initializeWebAudio()
        } catch {
            print("Could not initialize Web Audio: \(error)")
        }
    }

    private func initializeWebAudio() throws {
        let AudioContext = JSObject.global.AudioContext.function!
        let ctx = AudioContext.new()
        
        // TODO: Gain node?

        let osc = ctx.createOscillator!().object!
        osc.type = "triangle" // TODO: Other options
        osc.connect!(ctx.destination)

        audioAvailable = true
    }
}
