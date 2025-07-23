//
//  EditMemoryTypeSelectionList.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 23.07.2025.
//

import SwiftUI

struct EditMemoryTypeSelectionList: View {
    
    var body: some View {
        Button("SwiftData") {
            Task {
                await TransactionsService.shared.migrateToNewCacheType(.swiftData)
            }
        }
        Button("CoreData") {
            Task {
                await TransactionsService.shared.migrateToNewCacheType(.coreData)
            }
        }
        Button("Json файлы") {
            Task {
                await TransactionsService.shared.migrateToNewCacheType(.files)
            }
        }
    }
}
