import SwiftUI
import AppKit

struct ConvertWindow: View {
    @State private var inputPath: String = ""
    @State private var outputPath: String = ""
    @State private var selectedFormat: String = "PDF"

    let formats = [
        "PDF",
        "Microsoft Office (.docx, .xlsx, .pptx)",
        "LibreOffice (.odt, .ods, .odp)",
        "iWork (.pages, .numbers, .key)"
    ]

    var body: some View {
        VStack {
            Text("Welcome to iWorkConvert!")
                .font(.headline)
                .padding()

            VStack(alignment: .leading) {
                Text("Select the file to convert:")
                HStack {
                    TextField("Select file...", text: $inputPath)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)
                    Button("Browse") {
                        inputPath = selectFile()
                    }
                }
            }
            .padding()

            VStack(alignment: .leading) {
                Text("Select output folder:")
                HStack {
                    TextField("Select folder...", text: $outputPath)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)
                    Button("Browse") {
                        outputPath = selectFolder()
                    }
                }
            }
            .padding()

            VStack(alignment: .leading) {
                Text("Select output format:")
                Picker("Format", selection: $selectedFormat) {
                    ForEach(formats, id: \.self) { format in
                        Text(format)
                    }
                }
                .pickerStyle(MenuPickerStyle()) // ✅ Changed to a macOS-style dropdown list
                .frame(width: 300)
            }
            .padding()

            Button("Convert!") {
                convertFile()
            }
            .padding()
        }
        .frame(width: 400, height: 300) // Increased window height to fit everything
    }

    func selectFile() -> String {
        let panel = NSOpenPanel()
        panel.allowedFileTypes = ["pages", "numbers", "key", "docx", "xlsx", "pptx", "odt", "ods", "odp"]
        if panel.runModal() == .OK {
            return panel.url?.path ?? ""
        }
        return ""
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

    func convertFile() {
        let converter = FileConverter()
        converter.convert(inputPath: inputPath, outputPath: outputPath, format: selectedFormat)
    }
}
