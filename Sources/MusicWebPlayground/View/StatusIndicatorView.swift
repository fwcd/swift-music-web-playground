import Foundation
import TokamakDOM

struct StatusIndicatorView: View {
    var active: Bool? = nil
    var label: String? = nil
    var size: CGFloat = 14

    var body: some View {
        HStack {
            Circle()
                .frame(width: size, height: size)
                .foregroundColor(active.map { $0 ? .green : .red } ?? .gray)
            if let label = label {
                Text(label)
            }
        }
    }
}
