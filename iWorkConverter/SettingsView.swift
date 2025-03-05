import SwiftUI

struct SettingsView: View {
    @AppStorage("language") private var language = "English"
    @AppStorage("defaultSavePath") private var defaultSavePath = ""
    @AppStorage("alwaysChoosePath") private var alwaysChoosePath = false
    @State private var showUpdatePopup = false

    var body: some View {
        TabView {
            VStack {
                Picker("Language:", selection: $language) {
                    Text("English").tag("English")
                    Text("French").tag("French")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                HStack {
                    Text("Default save path:")
                    TextField("Select folder...", text: $defaultSavePath)
                        .disabled(alwaysChoosePath)
                    Button("Browse") {
                        defaultSavePath = selectFolder()
                    }
                }
                .padding()

                Toggle("Always choose where to save", isOn: $alwaysChoosePath)
                    .padding()
            }
            .tabItem { Text("General") }

            VStack {
                Button("Verify updates now") {
                    checkForUpdates()
                }
                .padding()

                Toggle("Update automatically", isOn: .constant(true))
                Toggle("Download updates automatically", isOn: .constant(true))
                Toggle("Install updates automatically", isOn: .constant(true))
            }
            .tabItem { Text("Update") }
        }
        .alert(isPresented: $showUpdatePopup) {
            Alert(
                title: Text("Update Available"),
                message: Text("A new version of iWorkConvert is available."),
                primaryButton: .default(Text("Download Update"), action: {
                    if let url = URL(string: "https://github.com/acer51-doctom/iWorkConverter/releases/latest") {
                        NSWorkspace.shared.open(url)
                    }
                }),
                secondaryButton: .cancel()
            )
        }
    }

    func checkForUpdates() {
        showUpdatePopup = true
    }

    func selectFolder() -> String {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        if panel.runModal() == .OK {
            return panel.url?.path ?? ""
        }
        return ""
    }
}
