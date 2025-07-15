//
//  TransactionUIView.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.07.2025.
//

import Foundation
import SwiftUI

class TransactionUIView: UIView {
    
    private lazy var categoryName: UILabel = {
        let label = UILabel()
        label.text = transaction.category.name
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "\(transaction.amount.formatted()) \(transaction.account.currencySymbol)"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.text = transaction.category.emoji.description
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightAccent
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    private var transaction: Transaction
    

    init(transaction: Transaction) {
        self.transaction = transaction
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupView() {
        addSubview(circleView)
        circleView.addSubview(emojiLabel)
        addSubview(categoryName)
        addSubview(amountLabel)
        addSubview(separatorView)
        // Добавляем commentLabel, если есть комментарий
        if let comment = transaction.comment, !comment.isEmpty {
            commentLabel.text = comment
            addSubview(commentLabel)
        }
        NSLayoutConstraint.activate([
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 32),
            circleView.heightAnchor.constraint(equalToConstant: 32),
            emojiLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            categoryName.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 12),
            categoryName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            categoryName.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor, constant: -8),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: categoryName.trailingAnchor, constant: 8),
            separatorView.leadingAnchor.constraint(equalTo: categoryName.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
        ])
        if let comment = transaction.comment, !comment.isEmpty {
            NSLayoutConstraint.activate([
                commentLabel.leadingAnchor.constraint(equalTo: categoryName.leadingAnchor),
                commentLabel.topAnchor.constraint(equalTo: categoryName.bottomAnchor, constant: 2),
                commentLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor, constant: -8),
                commentLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8)
            ])
        } else {
            NSLayoutConstraint.activate([
                categoryName.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
        categoryName.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        amountLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        amountLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}
