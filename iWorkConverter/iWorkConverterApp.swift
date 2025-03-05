import SwiftUI

@main
struct iWorkConvertApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView() // ✅ Prevents the app from quitting immediately
        }
    }
}
