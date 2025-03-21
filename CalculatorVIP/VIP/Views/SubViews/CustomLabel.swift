//
//  CustomLabel.swift
//  CalculatorVIP
//
//  Created by Samandar on 20/03/25.
//
import UIKit

final class CustomLabel: UILabel {
   
    init(text: String = "0",
         font: UIFont = UIFont.systemFont(ofSize: 55, weight: .bold),
         minimumScaleFactor: CGFloat = 0.6,
         adjustsFontSizeToFitWidth: Bool = true,
         textAlignment: NSTextAlignment  = .right,
         textColor: UIColor = UIColor.theme.labelCalcColor
    ){
        super.init(frame: .zero)
        
        self.text = text
        self.font = font
        self.minimumScaleFactor = minimumScaleFactor
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.textAlignment = textAlignment
        self.textColor = textColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
