//
//  ViewController.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/11/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//
import AVFoundation
import UIKit

class ViewController: UIViewController, InputInterfaceDelegate {
    
    var outputController1 : OutputInterface? = nil
      var checkInput = CheckingTheCorrectInput()
  
   
   // fuction which clear last element
    func clear(_ clean: Memory) {
       checkInput.clear(.clear)
    }
// fuction which clean all value
    func allClean(_ clean: Memory) {
        checkInput.allClean(.allClean)
    }

  // call function which check input fuction
    func digitPressed(_ value: String) {
       checkInput.digit(value)
    }
     // call function which check input operation
    func operationPressed(_ operation: Operation){
        checkInput.operation(operation)
    }
    
  // call function which check input fuction
    func functionPressed(_ function: Function) {
        checkInput.function(Function(rawValue: function.rawValue)!)
    }
 
     // call function which check input utility
    func utilityPressed(_ utility: Utility) {
        checkInput.utility(utility)
   }
    
    // call function which check input constant
    func constantPressed(_ const: Constants) {
        checkInput.constants(Constants(rawValue: const.rawValue)!)
    }

 // connects InputViewController and OutputViewController with ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inputInfo"{
            let destinationVC = segue.destination as! InputViewController
            destinationVC.delegate = self
        } else if segue.identifier == "outputInfo"{
            outputController1 = segue.destination as?  OutputViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkInput.resultClosure = { (value, eror) ->() in
            if value != Double.infinity && value != -(Double.infinity) && !(value?.isNaN)!{
                if (value != nil) {
                    self.ifResultIsDouble(value!)
                }
            } else {
                self.errorPrint(value!)
            }
        }
    }
    // Print error in Label
    func errorPrint (_ val: Double){
        let error = (String)(val)
        outputController1?.cleanLabel()
        outputController1?.displayResult(error, operatorPressed: false)
    }
    // Check if result is double or string
    func ifResultIsDouble(_ val: Double){ //verifing Double or Int
        if Double(Int64.max) > val {
            let value = (Int64)(val)
            let r  = val - (Double)(value)
            if r == 0 {
                let operation = (String)(value)
                outputController1?.cleanLabel()
                outputController1?.displayResult(operation, operatorPressed: false)
                outputController1?.clearDisplay(operation)
                checkInput.dotPressed = false
            } else  {
                let operation = (String)(val)
                outputController1?.cleanLabel()
                outputController1?.displayResult(operation , operatorPressed: false)
                outputController1?.clearDisplay(operation)
                checkInput.dotPressed = true
            }
            
        } else {
            outputController1?.cleanLabel()
            outputController1?.displayResult("value too large", operatorPressed: false)
        }
    }
    // Do any additional setup after loading the view, typically from a nib.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
    
    




