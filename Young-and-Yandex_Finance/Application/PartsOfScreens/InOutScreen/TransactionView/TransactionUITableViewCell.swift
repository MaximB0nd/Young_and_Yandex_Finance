//
//  TransactionUITableViewCell.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.07.2025.
//

import Foundation
import SwiftUI

class TransactionTableViewCell: UITableViewCell {
    static let identifier = "TransactionCell"
    
    private var transactionView: TransactionUIView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func configure(with transaction: Transaction) {
        transactionView?.removeFromSuperview()
        
        transactionView = TransactionUIView(transaction: transaction)
        transactionView?.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(transactionView!)
        
        NSLayoutConstraint.activate([
            transactionView!.topAnchor.constraint(equalTo: contentView.topAnchor),
            transactionView!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            transactionView!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            transactionView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
