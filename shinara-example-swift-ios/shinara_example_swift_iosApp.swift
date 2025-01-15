import SwiftUI
import ShinaraSDK

@main
struct shinara_example_swift_iosApp: App {
    init() {
        Task {
            do {
                // TODO: Replace with your own API Key
                try await ShinaraSDK.instance.initialize(apiKey: "<API KEY>")
            } catch {
                print("Error initializing Shinara SDK: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
