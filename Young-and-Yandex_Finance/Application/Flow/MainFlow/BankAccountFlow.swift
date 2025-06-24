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
}

struct BankAccountFlow: View {
    
    @State var mode: BankAccountFlowMode = .loading
    @ObservedObject var bankAccountService: BankAccountsService
    @State var account: BankAccount?
    
    var body: some View {
        ZStack{
            switch mode {
            case .loading:
                LoadingView()
                    .transition(.opacity)
                
            case .state:
                StateBankAccountFlow(mode: $mode, account: $account, bankAccountService: bankAccountService)
                    .transition(.opacity)
                
                
            case .edit:
                EditBankAccountFlow(mode: $mode, account: $account, bankAccountService: bankAccountService)
                    .transition(.opacity)
            }
        }.task {
            account = try? await bankAccountService.getAccount(id: 1)
            mode = .state
        }
    }
}
