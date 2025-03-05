import SwiftUI
import AppKit

struct ConvertWindow: View {
    @State private var inputPath: String = ""
    @State private var outputPath: String = ""
    @State private var selectedFormat: String = "PDF"

    var formats: [String] {
        let fileExtension = (inputPath as NSString).pathExtension.lowercased()
        switch fileExtension {
        case "pages":
            return ["PDF", "Microsoft Word (.docx)", "LibreOffice (.odt)"]
        case "key":
            return ["PDF", "PowerPoint (.pptx)", "LibreOffice (.odp)"]
        case "numbers":
            return ["PDF", "Excel (.xlsx)", "LibreOffice (.ods)"]
        default:
            return ["PDF"]
        }
    }

    var body: some View {
        VStack {
            Text("Welcome to iWorkConvert!").font(.headline).padding()

            HStack {
                TextField("Select file...", text: $inputPath).disabled(true)
                Button("Browse") { inputPath = selectFile() }
            }.padding()

            HStack {
                TextField("Select folder...", text: $outputPath).disabled(true)
                Button("Browse") { outputPath = selectFolder() }
            }.padding()

            Picker("Format", selection: $selectedFormat) {
                ForEach(formats, id: \.self) { format in Text(format) }
            }
            .pickerStyle(MenuPickerStyle())

            Button("Convert!") {
                convertFile()
            }
            .padding(.bottom, 10)
        }
        .frame(width: 500, height: 350)
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
