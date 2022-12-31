import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!

    private var isFinishedTypingNumer: Bool = true
    
    private var displayValue: Double {
        get {
            if let number = Double(displayLabel.text!)  {
                return number
            }
            return 0.0
        }
        set {
            if String(newValue) == "inf"{
                displayLabel.text = "Not a Number"
            } else{
                displayLabel.text = String(newValue)
            }
        }
    }
    
    private var calculator = CalculatorLogic()
    @IBAction func calcButtonPressed(_ sender: UIButton) {

        isFinishedTypingNumer = true
        calculator.setNumber(displayValue)
        if let calcMethod = sender.currentTitle {
            
            if let result = calculator.calculate(symbol: calcMethod){
                displayValue = result
            }
            
        }

    }


    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumer {
                displayLabel.text = numValue
                isFinishedTypingNumer = false
            } else {
                if numValue == "." {
                    
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
                displayLabel.text?.append(numValue)
            }

        }

    }

}

