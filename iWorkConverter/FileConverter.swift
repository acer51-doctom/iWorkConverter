//
//  FileConverter.swift
//  iWorkConverter
//
//  Created by Arthur on 05/03/2025.
//


import Foundation

class FileConverter {
    func convert(inputPath: String, outputPath: String, format: String) {
        var command = ""

        switch format {
        case "PDF":
            command = "osascript -e 'tell application \"Pages\" to export document 1 to file \"\(outputPath).pdf\" as PDF'"
        case "Microsoft Office (.docx, .xlsx, .pptx)":
            command = "soffice --headless --convert-to docx,xlsx,pptx \"\(inputPath)\" --outdir \"\(outputPath)\""
        case "LibreOffice (.odt, .ods, .odp)":
            command = "soffice --headless --convert-to odt,ods,odp \"\(inputPath)\" --outdir \"\(outputPath)\""
        case "iWork (.pages, .numbers, .key)":
            command = "osascript -e 'tell application \"Pages\" to open \"\(inputPath)\"' -e 'tell application \"Pages\" to save document 1 as \"\(outputPath)\"'"
        default:
            print("Unsupported format")
            return
        }

        _ = shell(command)
    }

    func shell(_ command: String) -> String {
        let task = Process()
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.launchPath = "/bin/zsh"
        task.launch()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8) ?? ""
    }
}
