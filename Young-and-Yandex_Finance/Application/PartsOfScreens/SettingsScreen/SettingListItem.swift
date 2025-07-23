//
//  SettingListItem.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 23.07.2025.
//

import SwiftUI

struct SettingListItem: View {
    
    let resourceImage: ImageResource
    let text: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(resourceImage)
                .resizable()
                .clipShape(.buttonBorder)
                .frame(width: 24, height: 24)

            Text(text)
            
            Spacer()
            
            Image(systemName: "chevron.forward")
        }
    }
}

