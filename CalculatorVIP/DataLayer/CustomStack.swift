//
//  RPNStack.swift
//  CalculatorVIP
//
//  Created by Samandar on 18/03/25.
//

import Foundation


struct CustomStack<T> {
    
    private var elements: [T] = [] {
        didSet { showElements() }
    }
    
    private let identifier: String
    
    init(identifier: String = "Stack") {
        self.identifier = identifier
    }
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        elements.popLast()
    }
    
    var peek: T? {
        elements.last
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var allElements: [T] {
        elements
    }
    
    private func showElements() {
        print("\(identifier): \(elements)")
    }
}


