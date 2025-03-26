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




//struct CustomStack<T> {
//        
//    private var elements: [T] = [] {
//        didSet {
//            showElements()
//        }
//    }
//    
//    mutating func push(element: T) {
//        elements.append(element)
//    }
//    
//    mutating func pop() -> T? {
//        
//        if elements.isEmpty {
//            return nil
//        }
//        return elements.removeLast()
//    }
//    
//    func peak() -> T? {
//            return elements.last
//        }
//    
//    func isEmpty() -> Bool {
//            return elements.isEmpty
//        }
//    
//    func allElements() -> [T] {
//        return elements
//    }
//    
//    
//    private func showElements() {
//        print("Calculation \(elements)")
//    }
//    
//}
//
//
//
//struct CustomStackForOP<T> {
//        
//    private var elements: [T] = [] {
//        didSet {
//            showElements()
//        }
//    }
//    
//    
//    mutating func push(element: T) {
//        elements.append(element)
//    }
//    
//    mutating func pop() -> T? {
//        
//        if elements.isEmpty {
//            return nil
//        }
//        return elements.removeLast()
//    }
//    
//    func peak() -> T? {
//            return elements.last
//        }
//    
//    func isEmpty() -> Bool {
//            return elements.isEmpty
//        }
//    
//    func allElements() -> [T] {
//        return elements
//    }
//    
//    private func showElements() {
//        print("Oper Arr \(elements)")
//    }
//}
//
//
//struct CustomStackForPostFix<T> {
//    
//    
//    private var elements: [T] = [] {
//        didSet {
//            showElements()
//        }
//    }
//    
//    mutating func push(element: T) {
//        elements.append(element)
//    }
//    
//    mutating func pop() -> T? {
//        
//        if elements.isEmpty {
//            return nil
//        }
//        return elements.removeLast()
//    }
//    
//    func peak() -> T? {
//            return elements.last
//        }
//    
//    func isEmpty() -> Bool {
//            return elements.isEmpty
//        }
//    
//    func allElements() -> [T] {
//        return elements
//    }
//    
//    private func showElements() {
//        print("Post Arr \(elements)")
//    }
//}
//
//
