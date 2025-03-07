import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var convertWindowController: NSWindowController?
    var settingsWindowController: NSWindowController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory) // ✅ Runs app in background
        setupMenuBar()
        checkLaunchAtLogin()
    }

    func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "doc.text", accessibilityDescription: "iWorkConvert")
            button.image?.isTemplate = true // ✅ Supports Light/Dark Mode
        }

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Convert", action: #selector(openConvertWindow), keyEquivalent: "C"))
        menu.addItem(NSMenuItem(title: "Settings", action: #selector(openSettings), keyEquivalent: "S"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "Q"))

        statusItem?.menu = menu
    }

    @objc func openConvertWindow() {
        if convertWindowController == nil {
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 500, height: 350),
                styleMask: [.titled, .closable, .resizable],
                backing: .buffered, defer: false
            )
            window.center()
            window.title = "iWorkConvert"
            window.contentView = NSHostingView(rootView: ConvertWindow())
            convertWindowController = NSWindowController(window: window)
        }
        convertWindowController?.showWindow(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    @objc func openSettings() {
        if settingsWindowController == nil {
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 450, height: 320),
                styleMask: [.titled, .closable, .resizable],
                backing: .buffered, defer: false
            )
            window.center()
            window.title = "Settings"
            window.contentView = NSHostingView(rootView: SettingsView())
            settingsWindowController = NSWindowController(window: window)
        }
        settingsWindowController?.showWindow(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    @objc func quitApp() {
        NSApp.terminate(nil)
    }

    func checkLaunchAtLogin() {
        let launchAtLogin = UserDefaults.standard.bool(forKey: "LaunchAtLogin")
        if launchAtLogin {
            // Add logic to enable launch at login
        }
    }
}
