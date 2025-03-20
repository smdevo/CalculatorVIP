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
        l: CGFloat? = nil,
        r: CGFloat? = nil,
        t: CGFloat? = nil,
        b: CGFloat? = nil,
        w: CGFloat? = nil,
        h: CGFloat? = nil,
        lToR: CGFloat? = nil,
        rToL: CGFloat? = nil,
        tToB: CGFloat? = nil,
        bToT: CGFloat? = nil,
        hGTAnchor: Bool = false,
        wGTAnchor: Bool = false
    ){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Simple
        if let left = l {
            leadingAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.leadingAnchor : hv.leadingAnchor,
                constant: left).isActive = true
        }
        if let right = r {
            trailingAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.trailingAnchor : hv.trailingAnchor,
                constant: right).isActive = true
        }
        if let top = t {
            topAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.topAnchor : hv.topAnchor,
                constant: top).isActive = true
        }
        if let bottom = b {
            bottomAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.bottomAnchor : hv.bottomAnchor,
                constant: bottom).isActive = true
        }
        
        //MARK: width, Height
        if let height = h {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = w {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if hGTAnchor {
            heightAnchor.constraint(greaterThanOrEqualTo: hv.heightAnchor).isActive = true
        }
        if wGTAnchor {
            widthAnchor.constraint(greaterThanOrEqualTo: hv.widthAnchor).isActive = true
        }
        
        
        //MARK: Reverse
        if let leftToRight = lToR {
            leadingAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.trailingAnchor : hv.trailingAnchor,
                constant: leftToRight).isActive = true
        }
        if let rightToLeft = rToL {
           trailingAnchor.constraint(
            equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.leadingAnchor : hv.leadingAnchor,
                constant: rightToLeft).isActive = true
        }
        if let topToBottom = tToB {
            topAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.bottomAnchor : hv.bottomAnchor,
                constant: topToBottom).isActive = true
        }
        if let bottomToTop = bToT {
            bottomAnchor.constraint(
                equalTo: isFromSafeArea ? hv.safeAreaLayoutGuide.topAnchor : hv.topAnchor,
                constant: bottomToTop).isActive = true
        }
        
    }

    
}



