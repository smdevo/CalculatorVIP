//
//  Trash.swift
//  CalculatorVIP
//
//  Created by Samandar on 25/03/25.
//

//    private func resetView() {
//        numberPadStackView.removeAllArrangedSubviews()
//        for subview in view.subviews {
//
//            print(subview)
//
//            subview.removeConstraints(subview.constraints)
//        }
//        for subview in scrollViewForLabel.subviews {
//            subview.removeConstraints(subview.constraints)
//        }
//        setConstraints()
//    }
  



//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        let isLandscape = UIDevice.current.orientation.isLandscape
//        interactor.didChangedOrientation(to: isLandscape ? .landscale : .portrait)
//    }


//    var lanscapeStructure: [[CButton]] = [
//        [.seven, .eight, .nine, .delete, .divide],
//        [.four, .five, .six,  .openBr, .multiply],
//        [.one, .two, .three, .closeBr, .minus],
//        [.clear, .zero, .dot, .equal, .add]
//    ]


//        if a {
//            interactor.processResultAndHistory(label: labelTitle, labelBtn: btn)
//
//            if btn == .equal {
//                a = false
//            }
//        }else {
//            if btn == .equal {
//
//                a = false
//
//            }else {
//
//                if
//                    [CButton.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, CButton.zero].contains(btn) ||
//                        (label.text != nil && label.text!.last != nil && label.text!.last!.isLetter)
//                {
//                    interactor.processResultAndHistory(label: "0", labelBtn: btn)
//                    a = true
//                }else {
//                    interactor.processResultAndHistory(label: labelTitle, labelBtn: btn)
//                }
//
//                a = true
//
//            }
//        }
       
        
        
//        interactor.processResult(label: labelTitle, labelBtn: btn)


//import Foundation
//
//extension Decimal {
//
//    var strDesc: String {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = (self >= 1 || self <= -1) ? 2 : 8
//        formatter.decimalSeparator = "."
//        formatter.groupingSeparator = ""
//
//        // Use `NSDecimalNumber` directly without converting to `Double`
//        let nsDecimal = self as NSDecimalNumber
//
//        // Check if scientific notation should be applied
//        if self > Decimal(1e8) || self < Decimal(-1e8) || (self != 0 && (self > Decimal(-1e-8) && self < Decimal(1e-8))) {
//            formatter.numberStyle = .scientific
//            formatter.exponentSymbol = "e"
//        }
//
//        return formatter.string(from: nsDecimal) ?? self.description
//    }
//}




//import Foundation
//
//extension Decimal {
//
//    var strDesc: String {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = 8
//        formatter.decimalSeparator = "."
//        formatter.groupingSeparator = ""     // Avoids spaces in large numbers
//
//        if self.exponent >= 8 || self.exponent <= -8 {
//
//            print("Exponent \(self.exponent)")
//
//            formatter.numberStyle = .scientific
//            formatter.exponentSymbol = "e"
//        }
//
//        print("Raw Decimal: \(self)") // Debugging print
//
//        return formatter.string(from: self as NSDecimalNumber) ?? self.description
//    }
//}
