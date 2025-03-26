//
//  CalculatorButton.swift
//  CalculatorVIP
//
//  Created by Macbook Pro on 17/03/25.
//

import UIKit

final class CalculatorButton: UIButton {
    init(button: CButton) {
        super.init(frame: .zero)
        setTitle(button.rawValue, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: .spacing(.x8), weight: .bold)
        setTitleColor(.white, for: .normal)
        backgroundColor = button.backgroundColor
        layer.cornerRadius = .spacing(.x6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
