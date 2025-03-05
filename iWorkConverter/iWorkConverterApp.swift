import SwiftUI

@main
struct iWorkConvertApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            SettingsView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMenuBar()
    }

    func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "doc.on.doc", accessibilityDescription: "iWorkConvert")
        }

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Convert", action: #selector(openConvertWindow), keyEquivalent: "C"))
        menu.addItem(NSMenuItem(title: "Settings", action: #selector(openSettings), keyEquivalent: "S"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "Q"))

        statusItem?.menu = menu
    }

    @objc func openConvertWindow() {
        ConvertWindowController.shared.showWindow()
    }

    @objc func openSettings() {
        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
    }

    @objc func quitApp() {
        NSApp.terminate(nil)
    }
}
