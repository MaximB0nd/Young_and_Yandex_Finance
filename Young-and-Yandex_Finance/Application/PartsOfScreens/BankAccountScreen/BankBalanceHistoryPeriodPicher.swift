//
//  BankBalanceHistoryPeriodPicher.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 26.07.2025.
//

import SwiftUI

struct BankBalanceHistoryPeriodPicher: View {
    
    @Binding var selectedPeriod: BankAccountsService.getBalancesPeriod
    
    var body: some View {
        Picker("Период", selection: $selectedPeriod) {
            ForEach(BankAccountsService.getBalancesPeriod.allCases, id: \.self) { caseItem in
                Text(caseItem.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
}
