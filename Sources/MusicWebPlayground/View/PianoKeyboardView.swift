import Foundation
import MusicTheory
import TokamakDOM

/// A view that renders an interactive piano keyboard.
struct PianoKeyboardView: View {
    var notes: [Note] = (0..<3).flatMap { octave in
        NoteClass.twelveToneOctave.map { Note(noteClass: $0, octave: octave) }
    }
    var blackKeyHeightFactor: Double = 0.7

    @EnvironmentObject private var viewModel: PianoKeyboardViewModel

    var body: some View {
        GeometryReader { geometry in // We need this reader so we can implement pressable
            let size = geometry.size

            // Compute the size of a single piano key
            // TODO: Use a better heuristic than assuming that we have multiple of 12 notes
            let whiteKeySize = CGSize(width: size.width / (7 * CGFloat(notes.count / 12)), height: size.height)
            let blackKeySize = CGSize(width: whiteKeySize.width / 2, height: whiteKeySize.height * blackKeyHeightFactor)

            // Sort notes to draw white keys, then black keys in order to get the z-order right
            let sortedNotes = notes.filter(\.accidental.isUnaltered) + notes.filter { !$0.accidental.isUnaltered }

            let boundingBox = { (note: Note) -> CGRect in
                CGRect(
                    origin: CGPoint(
                        x: (Double(7 * note.octave + note.letter.degree) + 0.5 + Double(note.accidental.semitones) * 0.25) * whiteKeySize.width,
                        y: 0
                    ),
                    size: note.accidental.isUnaltered ? whiteKeySize : blackKeySize
                )
            }

            Canvas { context, _ in
                // Draw the piano keys
                for note in sortedNotes {
                    let baseColor: Color = note.accidental.isUnaltered ? .white : .black
                    let color = viewModel.activeNotes.contains(note) ? baseColor.opacity(0.5) : baseColor

                    context.drawLayer { context in
                        context.fill(
                            Rectangle().path(in: boundingBox(note)),
                            with: .color(color)
                        )
                    }
                }
            }
            .pressable { pressed, point in
                if pressed {
                    viewModel.activeNotes = sortedNotes.last { boundingBox($0).contains(point) }.map { [$0] } ?? []
                } else {
                    viewModel.activeNotes = []
                }
            }
        }
    }
}
