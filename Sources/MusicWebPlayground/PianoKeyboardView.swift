import Foundation
import MusicTheory
import TokamakDOM

struct PianoKeyboardView: View {
    var notes: [Note] = (0..<3).flatMap { octave in
        NoteClass.twelveToneOctave.map { Note(noteClass: $0.first!, octave: octave) }
    }
    var noteSize = CGSize(width: 40, height: 200)

    @State private var pressedNotes: Set<Note> = []

    var body: some View {
        // TODO: Use Canvas instead (see e.g. https://github.com/TokamakUI/Tokamak/blob/10d9d32b978e538441c1a789612f9b7120cb003c/Sources/TokamakDemo/Drawing/CanvasDemo.swift)
        ZStack(alignment: .topLeading) {
            let offsetX = -((Double(notes.count) / 12) * 7 * noteSize.width) / 2
            ForEach(notes, id: \.semitone) { note in
                PianoKeyView(note: note, size: noteSize, pressed: pressedNotes.contains(note))
                    .pressable { pressed in
                        if pressed {
                            print("Pressed \(note)")
                            pressedNotes.insert(note)
                        } else {
                            pressedNotes.remove(note)
                        }
                    }
                    .positioned(at: CGPoint(
                        x: (Double(7 * note.octave + note.letter.degree) + Double(note.accidental.semitones) * 0.75) * noteSize.width + offsetX,
                        y: 0
                    ), zIndex: note.accidental == .unaltered ? 0 : 1)
            }
        }
    }
}
