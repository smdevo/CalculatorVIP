//
//  CustomTableView.swift
//  CalculatorVIP
//
//  Created by Samandar on 21/03/25.
//

import UIKit

final class CustomTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .grouped) // Specify a style
        
        allowsSelection = false
        separatorStyle = .none
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
