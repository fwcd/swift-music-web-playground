import TokamakDOM

/// A segmented picker that displays all cases from a string-based enum.
public struct EnumPicker<L, T>: View where L: View, T: CaseIterable & CustomStringConvertible & Hashable, T.AllCases: RandomAccessCollection, T.AllCases.Index == Int {
    @Binding private var selection: T
    private let label: L
    
    public init (selection: Binding<T>, label: L) {
        self._selection = selection
        self.label = label
    }
    
    public var body: some View {
        Picker(selection: $selection, label: label) {
            ForEach(T.allCases, id: \.self) {
                Text($0.description).tag($0)
            }
        }
    }
}
