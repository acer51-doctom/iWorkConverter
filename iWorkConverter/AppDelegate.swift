import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory) // ✅ Keeps app running in background
        setupMenuBar()
    }

    func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem?.button {
            print("✅ Status bar button loaded") // Debugging line
            button.image = NSImage(systemSymbolName: "doc.text", accessibilityDescription: "iWorkConvert")
            button.image?.isTemplate = true // ✅ Ensures icon adapts to Light/Dark mode
        } else {
            print("❌ Error: Status bar button not found!") // Debugging line
        }

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Convert", action: #selector(openConvertWindow), keyEquivalent: "C"))
        menu.addItem(NSMenuItem(title: "Settings", action: #selector(openSettings), keyEquivalent: "S"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "Q"))

        statusItem?.menu = menu
    }

    @objc func openConvertWindow() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 250),
            styleMask: [.titled, .closable],
            backing: .buffered, defer: false
        )
        window.center()
        window.title = "iWorkConvert"
        window.contentView = NSHostingView(rootView: ConvertWindow())
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    @objc func openSettings() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 200),
            styleMask: [.titled, .closable],
            backing: .buffered, defer: false
        )
        window.center()
        window.title = "Settings"
        window.contentView = NSHostingView(rootView: SettingsView())
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    @objc func quitApp() {
        print("Quitting app...") // Debugging line
        NSApp.terminate(nil)
    }
}
