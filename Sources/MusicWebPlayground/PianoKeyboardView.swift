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
        // TODO: Use Canvas instead (see e.g. https://github.com/TokamakUI/Tokamak/blob/10d9d32b978e538441c1a789612f9b7120cb003c/Sources/TokamakDemo/Drawing/CanvasDemo.swift)
        ZStack {
            ForEach(notes, id: \.semitone) { note in
                PianoKeyView(note: note, size: noteSize, pressed: pressedNotes.contains(note))
                    .pressable { pressed in
                        if pressed {
                            pressedNotes.insert(note)
                        } else {
                            pressedNotes.remove(note)
                        }
                    }
                    .positioned(at: CGPoint(
                        x: Double(7 * note.octave + note.letter.degree) * 1.1 * noteSize.width,
                        y: 0
                    )) // TODO: Positioning of black keys
            }
        }
    }
}
