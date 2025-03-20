//
//  CustomScrollView.swift
//  CalculatorVIP
//
//  Created by Samandar on 20/03/25.
//
import UIKit

final class CustomScrollView: UIScrollView {
    
    init(showsHorizontalScrollIndicator: Bool = false, alwaysBounceHorizontal: Bool = false) {
        super.init(frame: .zero)
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        self.alwaysBounceHorizontal = alwaysBounceHorizontal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
