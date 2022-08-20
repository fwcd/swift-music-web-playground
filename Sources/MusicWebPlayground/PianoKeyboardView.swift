import Foundation
import MusicTheory
import TokamakDOM

struct PianoKeyboardView: View {
    var notes: [Note] = (0..<3).flatMap { octave in
        NoteClass.twelveToneOctave.map { Note(noteClass: $0.first!, octave: octave) }
    }
    var noteSize = CGSize(width: 10, height: 50)

    @State private var pressedNotes: Set<Note> = []

    var body: some View {
        HStack {
            ForEach(notes, id: \.semitone) { note in
                PianoKeyView(note: note, size: noteSize, pressed: pressedNotes.contains(note))
                    .pressable { pressed in
                        if pressed {
                            pressedNotes.insert(note)
                        } else {
                            pressedNotes.remove(note)
                        }
                    }
            }
        }
    }
}
