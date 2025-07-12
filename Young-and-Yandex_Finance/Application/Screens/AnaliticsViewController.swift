//
//  AnaliticsViewController.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.07.2025.
//

import SwiftUI

class AnaliticsViewController: UIViewController {
    
    @Binding var selectedTransaction: Transaction?

    private let direction: Direction

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.07
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let periodStartLabel: UILabel = {
        let label = UILabel()
        label.text = "Период: начало"
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let periodStartPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor(named: "LightAccent")
        picker.layer.cornerRadius = 8
        picker.clipsToBounds = true
        return picker
    }()
    private let periodEndLabel: UILabel = {
        let label = UILabel()
        label.text = "Период: конец"
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let periodEndPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor(named: "LightAccent")
        picker.layer.cornerRadius = 8
        picker.clipsToBounds = true
        return picker
    }()
    private let sumLabel: UILabel = {
        let label = UILabel()
        label.text = "Сумма"
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sumValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0 ₽"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let separator1: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let separator2: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let separator3: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let operationsCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.07
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let operationsLabel: UILabel = {
        let label = UILabel()
        label.text = "ОПЕРАЦИИ"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let transactionsListView: TransactionsListUIView = {
        let view = TransactionsListUIView(frame: .zero, selectedTransaction: .constant(nil))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
 
    private var transactionsListViewHeightConstraint: NSLayoutConstraint?

    private var viewModel: MyHistoryTransactionListViewModel

    private let sortLabel: UILabel = {
        let label = UILabel()
        label.text = "Сортировка"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Не выбрано", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.contentHorizontalAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var sortSelection: SortSelectionType = .none

    init(direction: Direction = .outcome, transaction: Binding<Transaction?>) {
        self._selectedTransaction = transaction
        self.direction = direction
        self.viewModel = MyHistoryTransactionListViewModel(direction: direction)
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        setupActions()
        setupInitialValues()
        setupSortMenu()
        loadDataAndUpdateUI()
    }
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
 
        contentStack.addArrangedSubview(cardView)
   
        contentStack.addArrangedSubview(operationsCardView)
        cardView.addSubview(periodStartLabel)
        cardView.addSubview(periodStartPicker)
        cardView.addSubview(separator1)
        cardView.addSubview(periodEndLabel)
        cardView.addSubview(periodEndPicker)
        cardView.addSubview(separator2)

        cardView.addSubview(sortLabel)
        cardView.addSubview(sortButton)
        cardView.addSubview(separator3)
        cardView.addSubview(sumLabel)
        cardView.addSubview(sumValueLabel)
        operationsCardView.addSubview(operationsLabel)
        operationsCardView.addSubview(transactionsListView)

        let listViewHeight = CGFloat(viewModel.transactions.count) * 56.0
        transactionsListViewHeightConstraint = transactionsListView.heightAnchor.constraint(equalToConstant: listViewHeight)
        transactionsListViewHeightConstraint?.isActive = true
       
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            cardView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 12),
            cardView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -12),
            cardView.heightAnchor.constraint(equalToConstant: 210),

            periodStartLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            periodStartLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
 
            periodStartPicker.centerYAnchor.constraint(equalTo: periodStartLabel.centerYAnchor),
            periodStartPicker.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
   
            separator1.topAnchor.constraint(equalTo: periodStartLabel.bottomAnchor, constant: 14),
            separator1.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0),
            separator1.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0),
            separator1.heightAnchor.constraint(equalToConstant: 1),

            periodEndLabel.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 14),
            periodEndLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
     
            periodEndPicker.centerYAnchor.constraint(equalTo: periodEndLabel.centerYAnchor),
            periodEndPicker.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
    
            separator2.topAnchor.constraint(equalTo: periodEndLabel.bottomAnchor, constant: 14),
            separator2.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0),
            separator2.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0),
            separator2.heightAnchor.constraint(equalToConstant: 1),

            sortLabel.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 14),
            sortLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),

            sortButton.centerYAnchor.constraint(equalTo: sortLabel.centerYAnchor),
            sortButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            sortButton.widthAnchor.constraint(equalToConstant: 140),
 
            separator3.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: 14),
            separator3.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0),
            separator3.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0),
            separator3.heightAnchor.constraint(equalToConstant: 1),
            
            sumLabel.topAnchor.constraint(equalTo: separator3.bottomAnchor, constant: 14),
            sumLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
         
            sumValueLabel.centerYAnchor.constraint(equalTo: sumLabel.centerYAnchor),
            sumValueLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
       
            operationsCardView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 12),
            operationsCardView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -12),
            operationsLabel.topAnchor.constraint(equalTo: operationsCardView.topAnchor, constant: 16),
            operationsLabel.leadingAnchor.constraint(equalTo: operationsCardView.leadingAnchor, constant: 16),
            transactionsListView.topAnchor.constraint(equalTo: operationsLabel.bottomAnchor, constant: 8),
            transactionsListView.leadingAnchor.constraint(equalTo: operationsCardView.leadingAnchor),
            transactionsListView.trailingAnchor.constraint(equalTo: operationsCardView.trailingAnchor),
            transactionsListView.bottomAnchor.constraint(equalTo: operationsCardView.bottomAnchor)
        ])
    }
    private func setupActions() {
        periodStartPicker.addTarget(self, action: #selector(startDateChanged), for: .valueChanged)
        periodEndPicker.addTarget(self, action: #selector(endDateChanged), for: .valueChanged)
        setupSortMenu()
    }
    private func setupSortMenu() {
        let menu = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "Не выбрано", state: sortSelection == .none ? .on : .off) { [weak self] _ in
                self?.sortSelection = .none
                self?.viewModel.sortSelection = .none
                self?.updateSortButtonTitle()
                self?.loadDataAndUpdateUI()
            },
            UIAction(title: "Дата", state: sortSelection == .date ? .on : .off) { [weak self] _ in
                self?.sortSelection = .date
                self?.viewModel.sortSelection = .date
                self?.updateSortButtonTitle()
                self?.loadDataAndUpdateUI()
            },
            UIAction(title: "Сумма", state: sortSelection == .price ? .on : .off) { [weak self] _ in
                self?.sortSelection = .price
                self?.viewModel.sortSelection = .price
                self?.updateSortButtonTitle()
                self?.loadDataAndUpdateUI()
            }
        ])
        sortButton.menu = menu
        sortButton.showsMenuAsPrimaryAction = true
    }
    private func updateSortButtonTitle() {
        switch sortSelection {
        case .none:
            sortButton.setTitle("Не выбрано", for: .normal)
            sortButton.setTitleColor(.gray, for: .normal)
        case .date:
            sortButton.setTitle("Дата", for: .normal)
            sortButton.setTitleColor(.label, for: .normal)
        case .price:
            sortButton.setTitle("Сумма", for: .normal)
            sortButton.setTitleColor(.label, for: .normal)
        }
    }
    private func setupInitialValues() {
        periodStartPicker.date = viewModel.dateFrom
        periodEndPicker.date = viewModel.dateTo
    }
    @objc private func startDateChanged() {
        let start = periodStartPicker.date
        var end = periodEndPicker.date
        if start > end {
            end = start
            periodEndPicker.date = end
        }
        let startOfDay = DateConverter.startOfDay(start)
        let endOfDay = DateConverter.endOfDay(end)
        viewModel.dateFrom = startOfDay
        viewModel.dateTo = endOfDay
        periodStartPicker.date = startOfDay
        periodEndPicker.date = endOfDay
        loadDataAndUpdateUI()
    }
    @objc private func endDateChanged() {
        var start = periodStartPicker.date
        let end = periodEndPicker.date
        if end < start {
            start = end
            periodStartPicker.date = start
        }
        let startOfDay = DateConverter.startOfDay(start)
        let endOfDay = DateConverter.endOfDay(end)
        viewModel.dateFrom = startOfDay
        viewModel.dateTo = endOfDay
        periodStartPicker.date = startOfDay
        periodEndPicker.date = endOfDay
        loadDataAndUpdateUI()
    }
    private func loadDataAndUpdateUI() {
        Task {
            await viewModel.updateTransactions()
            DispatchQueue.main.async {
                self.sumValueLabel.text = "\(self.viewModel.sum.formatted()) \(self.viewModel.currencySymbol)"
                self.transactionsListView.setTransactions(self.viewModel.transactions)

                let count = self.viewModel.transactions.count
                let height = CGFloat(count) * 56.0
                self.transactionsListViewHeightConstraint?.constant = height
                self.view.layoutIfNeeded()
            }
        }
    }
}

