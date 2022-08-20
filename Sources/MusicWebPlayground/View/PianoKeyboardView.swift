import Foundation
import MusicTheory
import TokamakDOM

struct PianoKeyboardView: View {
    var notes: [Note] = (0..<3).flatMap { octave in
        NoteClass.twelveToneOctave.map { Note(noteClass: $0.first!, octave: octave) }
    }
    var blackKeyHeightFactor: Double = 0.7

    @State private var pressedNotes: Set<Note> = []

    var body: some View {
        Canvas { context, size in
            // Compute the size of a single piano key
            // TODO: Use a better heuristic than assuming that we have multiple of 12 notes
            let whiteKeySize = CGSize(width: size.width / (7 * CGFloat(notes.count / 12)), height: size.height)
            let blackKeySize = CGSize(width: whiteKeySize.width / 2, height: whiteKeySize.height * blackKeyHeightFactor)

            // Sort notes to draw white keys, then black keys in order to get the z-order right
            let sortedNotes = notes.filter(\.accidental.isUnaltered) + notes.filter { !$0.accidental.isUnaltered }

            // Draw the piano keys
            for note in sortedNotes {
                let baseColor: Color = note.accidental.isUnaltered ? .white : .black
                let color = pressedNotes.contains(note) ? baseColor.opacity(0.5) : baseColor

                context.drawLayer { context in
                    context.translateBy(
                        x: (Double(7 * note.octave + note.letter.degree) + Double(note.accidental.semitones) * 0.75) * whiteKeySize.width,
                        y: 0
                    )
                    context.fill(
                        Rectangle().path(in: CGRect(
                            origin: .zero,
                            size: note.accidental.isUnaltered ? whiteKeySize : blackKeySize
                        )),
                        with: .color(color)
                    )
                }
            }
        }
        .pressable { pressed, point in
            if pressed {
                pressedNotes = [notes.first!] // TODO
            } else {
                pressedNotes = []
            }
        }
    }
}
