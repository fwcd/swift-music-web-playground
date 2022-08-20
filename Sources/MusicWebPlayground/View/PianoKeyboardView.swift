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
        Canvas { context, size in
            // TODO: Respect size

            // Sort notes to draw white keys, then black keys in order to get the z-order right
            let sortedNotes = notes.filter(\.accidental.isUnaltered) + notes.filter { !$0.accidental.isUnaltered }

            for note in sortedNotes {
                context.drawLayer { context in
                    context.translateBy(
                        x: (Double(7 * note.octave + note.letter.degree) + Double(note.accidental.semitones) * 0.75) * noteSize.width,
                        y: 0
                    )
                    context.fill(
                        Rectangle().path(in: CGRect(
                            origin: .zero,
                            size: note.accidental.isUnaltered ? noteSize : CGSize(width: noteSize.width / 2, height: noteSize.height * 0.8)
                        )),
                        with: .color(note.accidental.isUnaltered ? .white : .black)
                    )
                }
            }
        }
    }
}
