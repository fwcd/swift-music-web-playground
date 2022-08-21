import OpenCombine
import MusicTheory

class PianoKeyboardViewModel: ObservableObject {
    @Published var octaveRange = 1..<4
    @Published var activeNotes: Set<Note> = []

    private var cancellables: Set<AnyCancellable> = []

    init(midiManager: MidiManager) {
        midiManager.$activeMidiNotes
            .sink { [weak self] midiNumbers in
                self?.activeNotes = Set(midiNumbers.map { Note(midiNumber: $0) })
            }
            .store(in: &cancellables)
    }

    func shiftOctaveRange(by octaves: Int) {
        octaveRange = (octaveRange.lowerBound + octaves)..<(octaveRange.upperBound + octaves)
    }
}
