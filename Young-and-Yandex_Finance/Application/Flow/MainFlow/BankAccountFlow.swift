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
    var bankAccountService: BankAccountsService
    
    @ObservedObject var model: BankAccountFlowViewModel
    
    var body: some View {
        ZStack{
            switch mode {
            case .loading:
                LoadingView()
                    .transition(.opacity)
                    .task {
                        do {
                            try await model.fetchBankAccounts()
                            mode = .state
                        } catch {
                            mode = .error
                        }
                    }
                
            case .state:
                StateBankAccountFlow(mode: $mode, model: model)
                    .transition(.opacity)
                    .refreshable {
                        Task {
                            try await model.fetchBankAccounts()
                        }
                    }
                    
            case .edit:
                EditBankAccountFlow(mode: $mode, model: model)
                    .transition(.opacity)
                    
                
            case .error:
                ErrorScreen()
                    .refreshable {
                        Task {
                            try await model.fetchBankAccounts()
                        }
                    }
            }
        }
        .task {
            mode = .loading
            do {
                try await model.fetchBankAccounts()
                mode = .state
            } catch {
                mode = .error
            }
        }
        
    }
    
    init(bankAccountService: BankAccountsService) {
        self.bankAccountService = bankAccountService
        self.model = .init(id: 1)
    }
}
