import TokamakDOM

private let midiManager = MidiManager()
private let audioManager = AudioManager()
private let pianoKeyboardViewModel = PianoKeyboardViewModel(audioManager: audioManager, midiManager: midiManager)

@main
struct MusicWebPlaygroundApp: App {
    var body: some Scene {
        WindowGroup("Music Web Playground") {
            ContentView()
                .environmentObject(audioManager)
                .environmentObject(midiManager)
                .environmentObject(pianoKeyboardViewModel)
        }
    }
}
