//
//  CommentEdit.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import SwiftUI

struct CommentEdit: View {
    @Binding var comment: String
    
    var body: some View {
        TextField("Комментарий", text: $comment)
    }
}

