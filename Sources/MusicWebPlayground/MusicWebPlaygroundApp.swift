import TokamakDOM

private let midiManager = MidiManager()
private let pianoKeyboardViewModel = PianoKeyboardViewModel(midiManager: midiManager)

@main
struct MusicWebPlaygroundApp: App {
    var body: some Scene {
        WindowGroup("Music Web Playground") {
            ContentView()
                .environmentObject(midiManager)
                .environmentObject(pianoKeyboardViewModel)
        }
    }
}
