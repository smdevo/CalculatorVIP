//
//  StackView.swift
//  CalculatorVIP
//
//  Created by Macbook Pro on 17/03/25.
//

import UIKit

final class CustomStackView: UIStackView {
    init(
        axis: NSLayoutConstraint.Axis = .vertical,
        distribution: UIStackView.Distribution = .fillEqually,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = .zero
    ) {
        super.init(frame: .zero)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
