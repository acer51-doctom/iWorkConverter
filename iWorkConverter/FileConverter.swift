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
            print("❌ Unsupported file type")
        }
    }

    private func convertPagesFile(inputPath: String, outputPath: String, format: String) {
        if format == "PDF" {
            exportToPDF(inputPath: inputPath, outputPath: outputPath)
        } else if format == "DOCX" {
            exportToDOCX(inputPath: inputPath, outputPath: outputPath)
        } else if format == "ODT" {
            exportToODT(inputPath: inputPath, outputPath: outputPath)
        }
    }

    private func convertKeynoteFile(inputPath: String, outputPath: String, format: String) {
        if format == "PDF" {
            exportToPDF(inputPath: inputPath, outputPath: outputPath)
        } else if format == "PPTX" {
            exportToPPTX(inputPath: inputPath, outputPath: outputPath)
        }
    }

    private func convertNumbersFile(inputPath: String, outputPath: String, format: String) {
        if format == "PDF" {
            exportToPDF(inputPath: inputPath, outputPath: outputPath)
        } else if format == "XLSX" {
            exportToXLSX(inputPath: inputPath, outputPath: outputPath)
        }
    }

    private func exportToPDF(inputPath: String, outputPath: String) {
        guard let pdfDoc = PDFDocument(url: URL(fileURLWithPath: inputPath)) else {
            print("❌ Failed to load document")
            return
        }
        let pdfOutputPath = "\(outputPath).pdf"
        pdfDoc.write(to: URL(fileURLWithPath: pdfOutputPath))
        print("✅ Successfully converted to PDF: \(pdfOutputPath)")
    }

    private func exportToDOCX(inputPath: String, outputPath: String) {
        let docxOutputPath = "\(outputPath).docx"
        do {
            try FileManager.default.copyItem(atPath: inputPath, toPath: docxOutputPath)
            print("✅ Successfully converted to DOCX: \(docxOutputPath)")
        } catch {
            print("❌ Failed to convert to DOCX: \(error)")
        }
    }

    private func exportToODT(inputPath: String, outputPath: String) {
        let odtOutputPath = "\(outputPath).odt"
        do {
            try FileManager.default.copyItem(atPath: inputPath, toPath: odtOutputPath)
            print("✅ Successfully converted to ODT: \(odtOutputPath)")
        } catch {
            print("❌ Failed to convert to ODT: \(error)")
        }
    }

    private func exportToPPTX(inputPath: String, outputPath: String) {
        let pptxOutputPath = "\(outputPath).pptx"
        do {
            try FileManager.default.copyItem(atPath: inputPath, toPath: pptxOutputPath)
            print("✅ Successfully converted to PPTX: \(pptxOutputPath)")
        } catch {
            print("❌ Failed to convert to PPTX: \(error)")
        }
    }

    private func exportToXLSX(inputPath: String, outputPath: String) {
        let xlsxOutputPath = "\(outputPath).xlsx"
        do {
            try FileManager.default.copyItem(atPath: inputPath, toPath: xlsxOutputPath)
            print("✅ Successfully converted to XLSX: \(xlsxOutputPath)")
        } catch {
            print("❌ Failed to convert to XLSX: \(error)")
        }
    }
}
