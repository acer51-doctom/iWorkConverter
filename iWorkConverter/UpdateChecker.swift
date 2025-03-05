//
//  UpdateChecker.swift
//  iWorkConverter
//
//  Created by Arthur on 05/03/2025.
//


import Foundation

class UpdateChecker {
    func checkForUpdates(interval: String) {
        let latestVersion = fetchLatestVersionFromGitHub()
        let currentVersion = "0.1.0"

        if normalizeVersion(latestVersion) > normalizeVersion(currentVersion) {
            showUpdateAlert()
        }
    }

    private func normalizeVersion(_ version: String) -> String {
        return version.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
    }

    private func fetchLatestVersionFromGitHub() -> String {
        return "v0.1.1" // Simulating GitHub check
    }

    private func showUpdateAlert() {
        print("Update available!")
    }
}
