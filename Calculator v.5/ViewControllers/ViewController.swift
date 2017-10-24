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
  
   
    
    func clear(_ clean: Memory) {
       checkInput.clear(.clear)
    }

    func allClean(_ clean: Memory) {
        checkInput.allClean(.allClean)
    }

    
    func display(_ symbol: String) {

       // checkInput.opertString += symbol
      //  outputController1?.displayResult(symbol)
    }
 
    func digitPressed(_ value: String) {
       checkInput.digit(value)

    }
    
    func operationPressed(_ operation: Operation){
        print("OperationPreesed - \(operation)")
        checkInput.operation(operation)
       
    }


        
    
    func functionPressed(_ function: Function) {
        checkInput.function(Function(rawValue: function.rawValue)!)
    }
 
    
    func utilityPressed(_ utility: Utility) {
        checkInput.utility(utility)
   }
    
    func constantPressed(_ const: Constants) {
        checkInput.constants(Constants(rawValue: const.rawValue)!)
    }

 
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
                    self.checkInput.myCurrentValue = "\(value!)"
                    self.ifDouble(value!)
                }
            } else {
                self.errorPrint(value!)
            }
        }
    }
    
    func errorPrint (_ val: Double){
        let error = (String)(val)
        outputController1?.cleanLabel()
        outputController1?.displayResult(error, operatorPressed: false)
    }
    
    func ifDouble(_ val: Double){ //verifing Double or Int
        let value = (Int)(val)
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
           outputController1?.displayResult(operation, operatorPressed: false)
            outputController1?.clearDisplay(operation)
            checkInput.dotPressed = true
            print("print after ifDouble \(checkInput.dotPressed)")
        }   }
    // Do any additional setup after loading the view, typically from a nib.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
    
    




