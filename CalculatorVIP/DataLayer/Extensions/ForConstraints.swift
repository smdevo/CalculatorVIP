//
//  ForConstraints.swift
//  CalculatorVIP
//
//  Created by Samandar on 18/03/25.
//


import UIKit

extension  UIView {
    func setConstraints(
        helperView hv: UIView,
        isFromSafeArea: Bool = false,
        left: CGFloat? = nil,
        right: CGFloat? = nil,
        top: CGFloat? = nil,
        bottom: CGFloat? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        leftToRight: CGFloat? = nil,
        rightToLeft: CGFloat? = nil,
        topToBottom: CGFloat? = nil,
        bottomToTop: CGFloat? = nil,
        hGTAnchor: Bool = false,
        wGTAnchor: Bool = false
    ){
        translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: -Simple
        if let left {
            leadingAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.leadingAnchor : hv.leadingAnchor,
                constant: left).isActive = true
        }
        if let right {
            trailingAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.trailingAnchor : hv.trailingAnchor,
                constant: right).isActive = true
        }
        if let top  {
            topAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.topAnchor : hv.topAnchor,
                constant: top).isActive = true
        }
        if let bottom {
            bottomAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.bottomAnchor : hv.bottomAnchor,
                constant: bottom).isActive = true
        }
        
        //MARK: -width, Height
        if let height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if hGTAnchor {
            heightAnchor.constraint(greaterThanOrEqualTo: hv.heightAnchor).isActive = true
        }
        if wGTAnchor {
            widthAnchor.constraint(greaterThanOrEqualTo: hv.widthAnchor).isActive = true
        }
        
        //MARK: -Reverse
        if let leftToRight {
            leadingAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.trailingAnchor : hv.trailingAnchor,
                constant: leftToRight).isActive = true
        }
        if let rightToLeft {
           trailingAnchor.constraint(
            equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.leadingAnchor : hv.leadingAnchor,
                constant: rightToLeft).isActive = true
        }
        if let topToBottom {
            topAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.bottomAnchor : hv.bottomAnchor,
                constant: topToBottom).isActive = true
        }
        if let bottomToTop {
            bottomAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.topAnchor : hv.topAnchor,
                constant: bottomToTop).isActive = true
        }
    }
}



