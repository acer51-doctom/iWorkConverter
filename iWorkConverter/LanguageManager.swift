//
//  LanguageManager.swift
//  iWorkConverter
//
//  Created by Arthur on 05/03/2025.
//


import SwiftUI
import Combine

class LanguageManager: ObservableObject {
    @Published var language: String {
        didSet {
            UserDefaults.standard.set(language, forKey: "appLanguage")
            NotificationCenter.default.post(name: Notification.Name("LanguageChanged"), object: nil)
        }
    }

    init() {
        self.language = UserDefaults.standard.string(forKey: "appLanguage") ?? "English"
    }
}
