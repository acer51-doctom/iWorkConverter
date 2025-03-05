import SwiftUI

struct SettingsView: View {
    @AppStorage("language") private var language = "English"

    var body: some View {
        TabView {
            VStack {
                Picker("Language:", selection: $language) {
                    Text("English").tag("English")
                    Text("French").tag("French")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            .tabItem { Text("General") }

            VStack {
                Button("Verify updates now") {
                    checkForUpdates()
                }
            }
            .tabItem { Text("Update") }
        }
    }

    func checkForUpdates() {
        if let url = URL(string: "https://github.com/acer51-doctom/iWorkConverter/releases/latest") {
            NSWorkspace.shared.open(url)
        }
    }
}
