import SwiftUI
import AppKit

struct ConvertWindow: View {
    @State private var inputPath: String = ""
    @State private var outputPath: String = ""
    @State private var selectedFormat: String = "PDF"

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("iWorkConvert")
                .font(.headline)
                .padding(.top)

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
            .padding(.horizontal)

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
            .padding(.horizontal)

            VStack(alignment: .leading) {
                Text("Select output format:")
                Picker("Format", selection: $selectedFormat) {
                    Text("PDF").tag("PDF")
                    Text("Microsoft Word (.docx)").tag("DOCX")
                    Text("LibreOffice (.odt)").tag("ODT")
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)

            Button("Convert") {
                let converter = FileConverter()
                converter.convert(inputPath: inputPath, outputPath: outputPath, format: selectedFormat)
            }
            .padding(.top, 10)

            }
            .padding()
            .frame(maxWidth: .infinity)
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
}
