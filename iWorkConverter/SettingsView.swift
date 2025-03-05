import SwiftUI

struct SettingsView: View {
    @AppStorage("language") private var language = "English"
    @State private var showUpdatePopup = false

    var body: some View {
        VStack {
            Picker("Language:", selection: $language) {
                Text("English").tag("English")
                Text("French").tag("French")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button("Verify updates now") {
                checkForUpdates()
            }
            .padding()

        }
        .frame(width: 350, height: 200)
        .background(VisualEffectView(material: .sidebar, blendingMode: .behindWindow)) // Transparency
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
}
