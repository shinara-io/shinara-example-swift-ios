import SwiftUI
import ShinaraSDK

@main
struct shinara_example_swift_iosApp: App {
    init() {
        // TODO: Replace with your own API Key
        ShinaraSDK.instance.initialize(apiKey: "<API KEY>")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
