import Foundation
import MusicTheory
import TokamakDOM

struct PianoKeyView: View {
    let note: Note
    let size: CGSize
    var pressed: Bool = false

    private var baseColor: Color { .white }
    private var color: Color { baseColor.opacity(pressed ? 0.5 : 1) }

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: size.width, height: size.height)
    }
}
