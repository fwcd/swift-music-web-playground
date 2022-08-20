import TokamakDOM

@main
struct MusicWebPlaygroundApp: App {
    @StateObject private var midiManager = MidiManager()

    var body: some Scene {
        WindowGroup("Music Web Playground") {
            ContentView()
                .environmentObject(midiManager)
        }
    }
}
