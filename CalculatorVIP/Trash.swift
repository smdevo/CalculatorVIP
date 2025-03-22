//
//  Trash.swift
//  CalculatorVIP
//
//  Created by Samandar on 22/03/25.
//

//        tableView.setConstraints(
//            helperView: view,
//            left: .spacing(.x1),
//            right: -(.spacing(.x1)),
//            top: .spacing(.x1),
//            height: UIScreen.main.bounds.height / 2)
//
//
//        scrollViewForLabel.setConstraints(
//            helperView: view,
//            isFromSafeArea: true,
//            left: .spacing(.x2),
//            right: -(.spacing(.x2)),
//            height: 50)
//
//        scrollViewForLabel.setConstraints(
//            helperView: tableView,
//            topToBottom: 0)
//
//
//        label.setConstraints(
//            helperView: scrollViewForLabel,
//            hGTAnchor: true,
//            wGTAnchor: true)
//
//
//        numberPadStackView.setConstraints(
//            helperView: view,
//            isFromSafeArea: true,
//            left: .spacing(.x1),
//            right: -(.spacing(.x1)),
//            bottom: -(.spacing(.x1)))
//
//        numberPadStackView.setConstraints(
//            helperView: scrollViewForLabel,
//            topToBottom: .spacing(.x1))
        
        
//import UIKit
//
//final class CustomTableViewCell: UITableViewCell {
//
//    private let staticDateLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Date"
//        label.textColor = UIColor.theme.bracketColor
//        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let calculationLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor.theme.labelCalcColor
//        label.font = UIFont.systemFont(ofSize: .spacing(.x10), weight: .medium)
//        label.textAlignment = .right
//        label.adjustsFontSizeToFitWidth = true
//        label.numberOfLines = 2
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let dateLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor.theme.bracketColor
//        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//        label.textAlignment = .right
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let dateStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.spacing = 8
//        stackView.alignment = .center
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        backgroundColor = .clear
//
//        dateStackView.addArrangedSubview(staticDateLabel)
//        dateStackView.addArrangedSubview(dateLabel)
//
//        contentView.addSubview(dateStackView)
//        contentView.addSubview(calculationLabel)
//
//        NSLayoutConstraint.activate([
//            dateStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
//            dateStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            dateStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//
//            calculationLabel.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 4),
//            calculationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            calculationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            calculationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
//        ])
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configure(calculation: String, date: String) {
//        calculationLabel.text = calculation
//        dateLabel.text = date
//    }
//}






//import UIKit
//
//final class CustomTableViewCell: UITableViewCell {
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        textLabel?.textColor = UIColor.theme.labelCalcColor
//
//        textLabel?.font = UIFont.systemFont(ofSize: .spacing(.x10), weight: .medium)
//        textLabel?.textAlignment = .right
//        //textLabel?.adjustsFontSizeToFitWidth = true
//        textLabel?.numberOfLines = 0
//
//        backgroundColor = .clear
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}




//import UIKit
//
//protocol CustomTableViewCellDelegate: AnyObject {
//    func didTapDeleteButton(in cell: CustomTableViewCell)
//}
//
//final class CustomTableViewCell: UITableViewCell {
//
//    weak var delegate: CustomTableViewCellDelegate?
//
//    private let calculationLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor.theme.historyLabelColor
//        label.font = UIFont.systemFont(ofSize: .spacing(.x10), weight: .medium)
//        label.textAlignment = .right
//        label.adjustsFontSizeToFitWidth = true
//        label.numberOfLines = label.text?.count ?? 10 > 30 ? 0 : 2
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let dateLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor.theme.bracketColor
//        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//        label.textAlignment = .right
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let deleteButton: UIButton = {
//        let button = UIButton(type: .system)
//        let image = UIImage(systemName: "trash")
//        button.setImage(image, for: .normal)
//        button.tintColor = .theme.historyLabelColor
//        button.addTarget(CustomTableViewCell.self, action: #selector(deleteButtonTapped), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        backgroundColor = .clear
//
//        contentView.addSubview(deleteButton)
//        contentView.addSubview(calculationLabel)
//        contentView.addSubview(dateLabel)
//
//        NSLayoutConstraint.activate([
//            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            deleteButton.widthAnchor.constraint(equalToConstant: 30),
//            deleteButton.heightAnchor.constraint(equalToConstant: 30),
//
//            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
//            dateLabel.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 8),
//            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//
//            calculationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
//            calculationLabel.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 8),
//            calculationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            calculationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
//        ])
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configure(calculationStr: String, date: String) {
//        calculationLabel.text = calculationStr
//        dateLabel.text = date
//    }
//
//    @objc private func deleteButtonTapped() {
//        delegate?.didTapDeleteButton(in: self)
//    }
//}

