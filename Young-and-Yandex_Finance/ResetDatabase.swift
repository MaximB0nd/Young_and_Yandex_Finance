//
//  ResetDatabase.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 19.07.2025.
//

import Foundation

struct DatabaseReset {
    static func wipe() {
        let storeURL = URL.applicationSupportDirectory.appending(path: "default.store")
        
        let storeDirectory = storeURL.deletingLastPathComponent()
        let fileManager = FileManager.default
        
        do {
            // Удаляем ВСЕ файлы SwiftData
            let files = try fileManager.contentsOfDirectory(at: storeDirectory, includingPropertiesForKeys: nil)
            for file in files {
                try fileManager.removeItem(at: file)
                print("🔥 Удален файл SwiftData: \(file.lastPathComponent)")
            }
        } catch {
            print("⚠️ Ошибка удаления SwiftData: \(error)")
        }
    }
}
