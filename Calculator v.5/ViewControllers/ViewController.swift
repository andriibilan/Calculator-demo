//
//  ViewController.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/11/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, InputInterfaceDelegate {
    
    var outputController : OutputInterface? = nil
    private  var calc = CalcBrain()
   
    func clear(_ clean: Memory) {
        let clearedString = calc.clear(.clear)
        outputController?.clearDisplay(clearedString)
       
        
    }

    func allClean(_ clean: Memory) {
        calc.allClean(.allClean)
        outputController?.cleanLabel()
    }

    
    func display(_ symbol: String) {
        calc.opertString +=   symbol
        outputController?.display(symbol)
    }
 
    func digitPressed(_ value: Double) {
        calc.digit(value)
        let operation = (String)(value)
        outputController?.display(operation)
    }
    func operationPressed(_ operation: Operation){
        calc.operation(operation)
        outputController?.display(operation.rawValue)

    }
    func functionPressed(_ function: Function) {
        calc.function(function)
        outputController?.display(function.rawValue)
    }
    func utilityPressed(_ utility: Utility) {
        calc.utility(utility)
        outputController?.display(utility.rawValue)
    }
    func constantPressed(_ const: Constants) {
        calc.constants(const)
        outputController?.display(const.rawValue)
    }



    func plusMinus (_plus : Function){
        let rawValue =  outputController?.viewInDisplay()
        let value = (Double)(rawValue!)
        let value1 = value! * -1
        let value2 = (String)(value1)
        outputController?.display(value2)
        calc.function(.sign)
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inputInfo"{
            let destinationVC = segue.destination as! InputViewController
            destinationVC.delegate = self
        } else if segue.identifier == "outputInfo"{
            outputController = segue.destination as?  OutputViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calc.resultClosure = { (value, eror) ->() in
               if (value != nil) {
                    self.calc.opertString = "\(value!)"
                self.ifDouble(value!)
               }           }

    }
 
    
    func ifDouble(_ val: Double){ //verifing Double or Int
        let value = (Int)(val)
        let r  = val - (Double)(value)
        if r == 0 {
            let operation = (String)(value)
                 outputController?.cleanLabel()
            outputController?.display(operation)
            outputController?.clearDisplay(operation)
        } else  {
            let operation = (String)(val)
              outputController?.cleanLabel()
            outputController?.display(operation)
            outputController?.clearDisplay(operation)
        }   }
    // Do any additional setup after loading the view, typically from a nib.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
    
    




