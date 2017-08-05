//
//  ViewController.swift
//  MVC.Calculator
//
//  Created by Roman Bakhilov on 30.07.17.
//  Copyright © 2017 Roman Bakhilov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    var stillTyping = false
    var dotIsPlaced = true

    @IBAction func numberPressed(_ sender: UIButton) {
        
        let number = sender.currentTitle!
        
        if stillTyping {
            if (displayLabel.text?.characters.count)! < 15 {
                displayLabel.text = displayLabel.text! + number
            }
        } else {
            displayLabel.text = number
            stillTyping = true
            dotIsPlaced = true
        }
     }
    
    var displayValue: Double {
        get {
            return Double(displayLabel.text!)!
        } set {
         displayLabel.text = String(newValue)
        }
    }
    
    var operation = Calculation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func OnTouchDot(_ sender: Any) {
        if stillTyping && !dotIsPlaced {
            displayLabel.text = displayLabel.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            displayLabel.text = "0."
            stillTyping = true
        }
    }
    @IBAction func onTouchOpertion(_ sender: UIButton) {
        
        if stillTyping {
            operation.setOperand(operand: displayValue)
            stillTyping = false
            dotIsPlaced = true
        }
        
        if let mathSymbol = sender.currentTitle {
            operation.performOperation(symbol: mathSymbol)
        }
        displayValue = operation.result
    }
    
}

