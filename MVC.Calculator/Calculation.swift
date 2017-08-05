//
//  Calculation.swift
//  MVC.Calculator
//
//  Created by Roman Bakhilov on 30.07.17.
//  Copyright © 2017 Roman Bakhilov. All rights reserved.
//

import Foundation

let oneHunder = 100.0
var dotIsPlaced = false

class Calculation {
    
    var boofer = 0.0
    
    func setOperand(operand: Double) {
        boofer = operand
    }
    
    var Operation = [
        "√": operation.UnaryOperation(sqrt),
        "+/-":operation.UnaryOperation({-$0}),
        "×": operation.BinaryOperation({$0 * $1}),
        "÷": operation.BinaryOperation({$0 / $1}),
        "%": operation.UnaryOperation({$0 / oneHunder}),
        "−": operation.BinaryOperation({$0 - $1}),
        "+": operation.BinaryOperation({$0 + $1}),
        "=": operation.Equals,
        "C": operation.Clear,
        ".": operation.Dot
    ]
    
    enum operation {
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Clear
        case Dot
    }
    
    func performOperation(symbol: String)  {
        if let operation = Operation[symbol] {
            switch operation {
            case .UnaryOperation(let function): boofer = function(boofer)
            case .BinaryOperation(let function): executeEquels()
            pending = pendingBinaryOperationInfo(binaryOperation: function, firstOperand: boofer)
            case .Equals: executeEquels()
            case .Clear: executeClear()
            case .Dot: dotButtonPressed()
            }
        }

    }
    
    func executeEquels() {
        if pending != nil {
            boofer = pending!.binaryOperation(pending!.firstOperand, boofer)
            pending = nil
        }
    }
    
    func executeClear() {
        pending = nil
        boofer = 0
    }
    
    func dotButtonPressed() {
        
    }
   
    var pending: pendingBinaryOperationInfo?
    
    struct pendingBinaryOperationInfo {
        var binaryOperation: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get{
        return boofer
        }
    }
    
}
