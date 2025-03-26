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
        label.textColor = UIColor.theme.historyLabelColor
        label.font = UIFont.systemFont(ofSize: .spacing(.x10), weight: .medium)
        label.textAlignment = .right
        //label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = label.text?.count ?? 10 > 30 ? 0 : 2
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.bracketColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        contentView.addSubview(calculationLabel)
        contentView.addSubview(dateLabel)
        
        dateLabel.setConstraints(
            helperView: contentView,
            left: .spacing(.x4),
            right: -(.spacing(.x4)),
            top: .spacing(.x4))
        
        calculationLabel.setConstraints(
            helperView: contentView,
            left: .spacing(.x4),
            right: -(.spacing(.x4)),
            bottom: -(.spacing(.x4)))
        
        calculationLabel.setConstraints(
            helperView: dateLabel,
            topToBottom: .spacing(.x1))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(calculationStr: String, date: String) {
        calculationLabel.text = calculationStr
        dateLabel.text = date
    }
}



