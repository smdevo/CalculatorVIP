//
//  CalculatorButton.swift
//  CalculatorVIP
//
//  Created by Macbook Pro on 17/03/25.
//

import UIKit

final class CalculatorButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: .spacing(.x8), weight: .bold)
        setTitleColor(.white, for: .normal)
        backgroundColor = setBackgroundColorToEachButton(label: title)
        layer.cornerRadius = UIDevice.current.orientation.isLandscape ? .spacing(.x6) : .spacing(.x10)
    }
    
    private func setBackgroundColorToEachButton(label: String) -> UIColor {
        var color = UIColor.darkGray
        switch label {
        case "AC", "(", ")","⌫":
            color = .lightGray
        case "÷", "×", "－","+","=":
            color = .orange
        default: break
        }
        return color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
