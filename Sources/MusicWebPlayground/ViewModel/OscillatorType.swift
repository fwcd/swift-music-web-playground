enum OscillatorType: String, CaseIterable, Hashable, CustomStringConvertible {
    case sine
    case square
    case triangle

    var description: String {
        switch self {
        case .sine: return "Sine"
        case .square: return "Square"
        case .triangle: return "Triangle"
        }
    }
}
