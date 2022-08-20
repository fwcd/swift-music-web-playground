import Foundation
import MusicTheory
import TokamakDOM

struct PianoKeyboardView: View {
    var notes: [Note] = (0..<3).flatMap { octave in
        NoteClass.twelveToneOctave.map { Note(noteClass: $0.first!, octave: octave) }
    }
    var noteSize = CGSize(width: 10, height: 50)

    var body: some View {
        DynamicHTML(
            "div",
            listeners: [
                "mousedown": { _ in print("Mouse down") },
                "mouseup": { _ in print("Mouse up") },
                "mouseout": { _ in print("Mouse out") },
            ]
        ) {
            HStack {
                ForEach(notes, id: \.semitone) { note in
                    PianoKeyView(note: note, size: noteSize)
                }
            }
        }
    }
}
