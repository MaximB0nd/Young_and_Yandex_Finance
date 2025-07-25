//
//  BankAccountFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

enum BankAccountFlowMode {
    case loading
    case state
    case edit
    case error
}

struct BankAccountFlow: View {
    
    @State var mode: BankAccountFlowMode = .loading
    @State var model = BankAccountFlowViewModel.shared
    
    var body: some View {
        ZStack{
            switch mode {
            case .loading:
                LoadingView()
                    .transition(.opacity)
                    .task {
                        do {
                            try await model.updateBankAccounts()
                            mode = .state
                        } catch {
                            mode = .error
                        }
                    }
                
            case .state:
                StateBankAccountFlow(mode: $mode)
                    .transition(.opacity)
                    .refreshable {
                        Task {
                            try await model.updateBankAccounts()
                        }
                    }
                    
            case .edit:
                EditBankAccountFlow(mode: $mode)
                    .transition(.opacity)
                    
                
            case .error:
                ErrorScreen()
                    .refreshable {
                        Task {
                            try await model.updateBankAccounts()
                        }
                    }
            }
        }
        .task {
            mode = .loading
            do {
                try await model.updateBankAccounts()
                mode = .state
            } catch {
                mode = .error
            }
        }
        
    }
}
