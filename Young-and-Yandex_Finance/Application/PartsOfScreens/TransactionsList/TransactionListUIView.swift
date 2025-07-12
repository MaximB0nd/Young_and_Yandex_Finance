//
//  TransactionListUIView.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.07.2025.
//

import Foundation

import SwiftUI

protocol TransactionsListViewDelegate: AnyObject {
    func didSelectTransaction(_ transaction: Transaction)
    
    func transactionCellTapped(_ transaction: Transaction)
}

class TransactionsListUIView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private var transactions: [Transaction] = []
    
    @Binding var selectedTransaction: Transaction?
    
    init(frame: CGRect, selectedTransaction: Binding<Transaction?>) {
        self._selectedTransaction = selectedTransaction
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        // Настройка таблицы
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setTransactions(_ transactions: [Transaction]) {
        self.transactions = transactions
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TransactionTableViewCell.identifier,
            for: indexPath
        ) as? TransactionTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: transactions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let transaction = transactions[indexPath.row]
        
        selectedTransaction = transaction
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}
