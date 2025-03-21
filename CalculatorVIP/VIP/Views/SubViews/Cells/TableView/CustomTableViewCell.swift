//
//  CustomTableViewCell.swift
//  CalculatorVIP
//
//  Created by Samandar on 21/03/25.
//



import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    private let calculationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.labelCalcColor
        label.font = UIFont.systemFont(ofSize: .spacing(.x10), weight: .medium)
        label.textAlignment = .right
        //label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.bracketColor
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        contentView.addSubview(calculationLabel)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            calculationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            calculationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            calculationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            calculationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(calculationStr: String, date: String) {
        calculationLabel.text = calculationStr
        dateLabel.text = date
    }
}



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
