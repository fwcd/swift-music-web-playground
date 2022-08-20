import Foundation
import MusicTheory
import TokamakDOM

struct PianoKeyView: View {
    let note: Note
    let size: CGSize
    var pressed: Bool = false

    private var baseColor: Color { note.accidental == .unaltered ? .white : .black }
    private var color: Color { baseColor.opacity(pressed ? 0.5 : 1) }

    private var widthFactor: Double { note.accidental == .unaltered ? 1 : 0.5 }
    private var heightFactor: Double { note.accidental == .unaltered ? 1 : 0.8 }

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: size.width * widthFactor, height: size.height * heightFactor)
    }
}
