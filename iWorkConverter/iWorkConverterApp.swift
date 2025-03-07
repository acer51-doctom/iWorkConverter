import SwiftUI

@main
struct iWorkConvertApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var languageManager = LanguageManager()

    var body: some Scene {
        Settings {
            SettingsView()
                .environmentObject(languageManager) // ✅ Ensures language updates dynamically
        }
    }
}
