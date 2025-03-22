//
//  ForUIColor.swift
//  CalculatorVIP
//
//  Created by Macbook Pro on 20/03/25.
//

import UIKit

extension UIColor {
    
    static var theme = ColorTheme()
    
}


struct ColorTheme {
    let backgroundColor = UIColor(named: "calcBackgroundColor") ?? .black
    let numberColor = UIColor(named: "numberColor") ?? .darkGray
    let bracketColor = UIColor(named: "bracketColor") ?? .lightGray
    let operatorColor = UIColor(named: "operatorColor") ?? .orange
    let labelCalcColor = UIColor(named: "labelCalcColor") ?? .white
    let historyLabelColor = UIColor(named: "historyLabelColor") ?? .gray
}

