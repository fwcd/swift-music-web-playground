import TokamakDOM

/// A segmented picker that displays all cases from a string-based enum.
public struct EnumPicker<Selection, Label>: View
    where Selection: CaseIterable & CustomStringConvertible & Hashable,
          Selection.AllCases: RandomAccessCollection, Selection.AllCases.Index == Int,
          Label: View {
    @Binding var selection: Selection
    @ViewBuilder let label: () -> Label
    
    public var body: some View {
        Picker(selection: $selection, label: label()) {
            ForEach(Selection.allCases, id: \.self) {
                Text($0.description).tag($0)
            }
        }
    }
}
