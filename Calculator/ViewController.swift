//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var storedValue: String = ""
    
    private var isFinishedTypingNumber: Bool = true
    
    private var intermediateCalculation: (num1: Double, calcMethod: String) = (num1: 0.0, calcMethod: "")
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Can't convert display label text to a Double")
            }
            
            return number
        }
        set {
            if floor(newValue) == newValue {
                let roundedNumber = Int(newValue)
                displayLabel.text = String(roundedNumber)
                print(roundedNumber)
            } else {
                displayLabel.text = String(newValue)
            }
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        
        isFinishedTypingNumber = true
        
        if let calcMethod = sender.currentTitle {
            if calcMethod == "+/-" {
                displayValue *= -1
            } else if calcMethod == "AC" {
                displayLabel.text = "0"
                storedValue = ""
            } else if calcMethod == "%" {
                displayValue = displayValue/100
            } else if calcMethod == "="
                        && !(storedValue.contains("+/-")
                                || storedValue.contains("AC")
                                || storedValue.contains("%")
                                || storedValue.contains("=")) {
                if let safeResult = performCalculation(intermediateCalculation, displayValue) {
                    displayValue = safeResult
                } else {
                    displayLabel.text = "Invalid Input"
                }
            } else {
                intermediateCalculation = (num1: displayValue, calcMethod: calcMethod)
                storedValue = ""
            }
        }
        
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        
        if (sender.currentTitle == "." && storedValue.contains(".")) {
            return
        }
        
        
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                storedValue = ""
                
                displayLabel.text = numValue
                storedValue.append(numValue)
                isFinishedTypingNumber = false
            } else {
                
                displayLabel.text = storedValue + numValue
                storedValue.append(numValue)
            }
            
            
            
        }
        
    }
    
    func performCalculation(_ intermediateCalc: (num1: Double, calcMethod: String), _ num2: Double) -> Double? {
        
        switch intermediateCalc.calcMethod {
        
        case "+":
            return intermediateCalc.num1 + num2
        case "-":
            return intermediateCalc.num1 - num2
        case "×":
            return intermediateCalc.num1 * num2
        case "÷":
            if num2 != 0 {
                return intermediateCalc.num1 / num2
            } else {
                return nil
            }
        default:
            return nil
        }
        
    }
    
}

