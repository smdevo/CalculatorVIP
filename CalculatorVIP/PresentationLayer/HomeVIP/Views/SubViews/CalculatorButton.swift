//
//  CalculatorButton.swift
//  CalculatorVIP
//
//  Created by Macbook Pro on 17/03/25.
//

import UIKit

final class CalculatorButton: UIButton {
    init(button: CButton, type: UIButton.ButtonType) {
        super.init(frame: .zero)
        setTitle(button.rawValue, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: .spacing(.x8), weight: .bold)
        setTitleColor(.white, for: .normal)
        backgroundColor = button.backgroundColor
        layer.cornerRadius = UIDevice.current.orientation.isLandscape ? .spacing(.x5) : .spacing(.x7)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
