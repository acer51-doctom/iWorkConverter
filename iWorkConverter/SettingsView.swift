import SwiftUI

struct SettingsView: View {
    @AppStorage("language") private var language = "English"
    @AppStorage("defaultSavePath") private var defaultSavePath = ""
    @AppStorage("alwaysChoosePath") private var alwaysChoosePath = false
    @AppStorage("updateInterval") private var updateInterval = "Daily"
    
    @State private var showUpdatePopup = false
    
    let updateOptions = ["Hourly", "Daily", "Weekly", "Monthly", "Yearly", "Never"]

    var body: some View {
        VStack {
            TabView {
                VStack {
                    Text("General Settings").font(.headline).padding()

                    Picker("Language:", selection: $language) {
                        Text("English").tag("English")
                        Text("French").tag("French")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    HStack {
                        Text("Default Save Path:")
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
                    Text("Update Settings").font(.headline).padding()

                    Picker("Check for updates:", selection: $updateInterval) {
                        ForEach(updateOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()

                    Button("Check for Updates Now") {
                        checkForUpdates()
                    }
                    .padding()
                }
                .tabItem { Text("Update") }
            }
            .padding()
        }
        .frame(minWidth: 400, minHeight: 300) // ✅ Fully resizable window
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
