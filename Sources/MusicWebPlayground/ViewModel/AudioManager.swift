import OpenCombine
import JavaScriptKit
import MusicTheory

/// Handles interaction with the Web Audio API.
class AudioManager: ObservableObject {
    @Published private(set) var audioAvailable: Bool = false
    @Published var oscillatorType: OscillatorType = .sine

    private var audioContext: JSObject!
    private var gainNode: JSObject!
    private var oscillatorNodes: [Note: JSObject] = [:] {
        didSet {
            gainNode.gain.object!.value = .number(1 / max(1, Double(oscillatorNodes.count)))
        }
    }

    init() {
        do {
            try initializeWebAudio()
        } catch {
            print("Could not initialize Web Audio: \(error)")
        }
    }

    private func initializeWebAudio() throws {
        let AudioContext = JSObject.global.AudioContext.function!
        audioContext = AudioContext.new()
        
        // Create a gain node (without it, the oscillators would start clipping when played simultaneously)
        gainNode = audioContext.createGain!().object!
        gainNode.gain.object!.value = 1
        _ = gainNode.connect!(audioContext.destination)

        audioAvailable = true
    }

    /// Replaces the playing notes with the given notes.
    func keepPlaying(notes: Set<Note>) {
        let current = Set(oscillatorNodes.keys)
        let toStop = current.subtracting(notes)
        let toPlay = notes.subtracting(current)

        for note in toStop {
            stop(note: note)
        }

        for note in toPlay {
            play(note: note)
        }
    }

    /// Starts playing the given note.
    private func play(note: Note) {
        guard !oscillatorNodes.keys.contains(note) else { return }

        print("Playing \(note)")

        // Set up an oscillator node and start it
        let osc = audioContext.createOscillator!().object!
        _ = osc.connect!(gainNode)
        osc.type = .string(oscillatorType.rawValue)
        osc.frequency.object!.value = .number(EqualTemperament().pitchHz(for: note))
        _ = osc.start!()

        oscillatorNodes[note] = osc
    }

    /// Stops playing the given note.
    private func stop(note: Note) {
        if let osc = oscillatorNodes.removeValue(forKey: note) {
            print("Stopping \(note)")
            _ = osc.stop!()
        }
    }
}
