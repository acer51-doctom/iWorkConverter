//
//  FileConverter 2.swift
//  iWorkConverter
//
//  Created by Arthur on 05/03/2025.
//


import Foundation
import Quartz

class FileConverter {
    func convert(inputPath: String, outputPath: String, format: String) {
        let fileExtension = (inputPath as NSString).pathExtension.lowercased()
        let outputFile = "\(outputPath)/converted"

        switch fileExtension {
        case "pages":
            convertPagesFile(inputPath: inputPath, outputPath: outputFile, format: format)
        case "key":
            convertKeynoteFile(inputPath: inputPath, outputPath: outputFile, format: format)
        case "numbers":
            convertNumbersFile(inputPath: inputPath, outputPath: outputFile, format: format)
        default:
            print("Unsupported file type")
        }
    }

    private func convertPagesFile(inputPath: String, outputPath: String, format: String) {
        let doc = PDFDocument(url: URL(fileURLWithPath: inputPath))
        let savePath = "\(outputPath).pdf"
        doc?.write(to: URL(fileURLWithPath: savePath))
    }

    private func convertKeynoteFile(inputPath: String, outputPath: String, format: String) {
        // Implement Keynote conversion
    }

    private func convertNumbersFile(inputPath: String, outputPath: String, format: String) {
        // Implement Numbers conversion
    }
}
