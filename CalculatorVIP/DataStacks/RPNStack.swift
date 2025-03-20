//
//  RPNStack.swift
//  CalculatorVIP
//
//  Created by Samandar on 18/03/25.
//

import Foundation

//LIFO
/*
 1. Function Call Management
 When a function is called, its local variables, parameters, and return address are stored in the call stack.
 When the function completes, its data is removed from the stack.
 This allows for nested function calls and recursion to work properly.
 
 2. Efficient Memory Allocation
 The stack operates in a Last In, First Out (LIFO) manner, meaning the most recently added data is removed first.
 Memory allocation and deallocation on the stack are fast because they follow a simple push/pop operation.
 
 */
struct CustomStack<T> {
    
   // let postFixElements: [String]
    
   private var elements: [T] = []
    
    
    mutating func push(element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        
        if elements.isEmpty {
            return nil
        }
        return elements.removeLast()
    }
    
    var result: T? {
        return elements.last
    }
    
}


