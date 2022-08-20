import Foundation
import TokamakDOM

struct StatusIndicatorView: View {
    let active: Bool
    let label: String?
    var size: CGFloat = 14

    var body: some View {
        HStack {
            Circle()
                .frame(width: size, height: size)
                .foregroundColor(active ? .green : .red)
            if let label = label {
                Text(label)
            }
        }
    }
}
