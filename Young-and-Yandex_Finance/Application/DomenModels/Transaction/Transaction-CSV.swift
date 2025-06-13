//
//  Transaction-CSV.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 13.06.2025.
//

import Foundation

extension Transaction {
    
    ///
    ///function converts CSV Foundation data to [Transaction]
    ///it can work with random columns (as json)
    ///
    static func parce(CSV: Data, separator: String = ";", newline: String = "\r\n") async -> [Transaction]? {
        let info = String(data: CSV, encoding: .utf8)
        
        guard var rows = info?.split(separator: newline), rows.count > 1 else { return nil }

        let header = rows.removeFirst()
        let keys = header.split(separator: separator).map({ String($0) })
        
        var dict: [String: [String]] = [:]
        for key in keys {
            dict[String(key)] = []
        }
        
        for row in rows {
            var shift = 0
            let columns = row.split(separator: separator)
            guard columns.count >= keys.count-1 else { continue }
            for (j, value) in columns.enumerated() {
                if keys[j] == "comment" && columns.count < keys.count {
                    dict["comment"]!.append("")
                    shift = 1
                }
                dict[keys[j + shift]]?.append(String(value))
            }
        }
       
        var transactions: [Transaction] = []
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd.MM.yy HH:mm"
        
        for i in 0..<rows.count {
            guard let idStr = dict["id"]?[i],
                  let accountIdStr = dict["account_id"]?[i],
                  let accountName = dict["account_name"]?[i],
                  let accountBalanceStr = dict["account_balance"]?[i],
                  let accountCurrency = dict["account_currency"]?[i],
                  let categoryId = dict["category_id"]?[i],
                  let categoryName = dict["category_name"]?[i],
                  let categoryEmoji = dict["category_emoji"]?[i].first,
                  let categoryDirectionStr = dict["category_is_comming"]?[i],
                  let amountStr = dict["amount"]?[i],
                  let transactionDateStr = dict["transaction_date"]?[i],
                  let comment = dict["comment"]?[i],
                  let createdAtStr = dict["created_at"]?[i],
                  let updatedAtStr = dict["updated_at"]?[i]
            else { continue }
                  
            guard let id = Int(idStr),
                  let accountId = Int(accountIdStr),
                  let accountBalance = Decimal(string: accountBalanceStr),
                  let categoryId = Int(categoryId),
                  let categoryDirection: Direction = categoryDirectionStr == "true" ? .income : .outcome,
                  let amount = Decimal(string: amountStr),
                  let transactionDate = formatter.date(from: transactionDateStr),
                  let createdAt = formatter.date(from: createdAtStr),
                  let updatedAt = formatter.date(from: updatedAtStr)
            else { continue }
            
            transactions.append(Transaction(id: id, account: .init(id: accountId, name: accountName, balance: accountBalance, currency: accountCurrency), category: .init(id: categoryId, name: categoryName, emoji: categoryEmoji, direction: categoryDirection), amount: amount, transactionDate: transactionDate, comment: (comment=="") ? nil : comment, createdAt: createdAt, updatedAt: updatedAt))
        }
        return transactions
    }
}
