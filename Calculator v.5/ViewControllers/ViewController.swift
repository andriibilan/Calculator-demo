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
    var checkInput = CheckingTheCorrectInput()
    var output = OutputViewController()

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
    func operationPressed(_ operation: Operation) {
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
        if segue.identifier == "inputInfo" {
            let destinationVC = segue.destination as! InputViewController
            destinationVC.delegate = self
        } else if segue.identifier == "outputInfo" {
            output = (segue.destination as? OutputViewController)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constraint.constant = 0
        checkInput.resultClosure = { (value, eror) ->() in
            guard value != Double.infinity && value != -(Double.infinity) && !(value?.isNaN)! else {
               return self.errorPrint(value!)
            }
            guard value == nil else {
                 return self.ifResultIsDouble(value!)
            }
        }
    }
    // Print error in Label
    func errorPrint (_ val: Double) {
        let error = (String)(val)
        let current = output.currentTexTinDisplay()
        output.getHistoryArray(equation: current, result: error)
        output.displayResults(value: error)
    }
    
    // Check if result is double or string
    func ifResultIsDouble(_ val: Double) { //verifing Double or Int
        if Double(Int64.max) > val {
            let value = (Int64)(val)
            let r  = val - (Double)(value)
            if r == 0 {
                let operation = String(value)
                let current = output.currentTexTinDisplay()
                output.getHistoryArray(equation: current, result: operation)
                output.displayResults(value: operation)
                checkInput.dotPressed = false
            } else  {
                let operation = (String)(val)
                let current = output.currentTexTinDisplay()
                output.getHistoryArray(equation: current, result: operation)
                output.displayResults(value: operation)
                checkInput.dotPressed = true
            }
        } else {
            let current = output.currentTexTinDisplay()
            output.getHistoryArray(equation: current, result: "value too large")
            output.displayResults(value:  "value too large")
        }
    }

    
    @IBOutlet weak var outputView: UIView!
    
    @IBOutlet weak var constraint: NSLayoutConstraint!
     var topmenuHidden: Bool = true
    @IBAction func showHistory(_ sender: Any) {
        print("check bool: \(topmenuHidden)")
        if topmenuHidden {
            if UIDevice.current.orientation.isPortrait {
                constraint.constant = view.bounds.height - outputView.frame.height
            } else {
                constraint.constant = view.bounds.height - outputView.frame.height
            }
            print(outputView.frame.height)
            
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.output.hideHistoryOutput(changeLabel: true)
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                self.view.layoutIfNeeded()
            }, completion: {(final) in
                
            })
           
            topmenuHidden = false
        } else {
            constraint.constant = 0
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(final) in
                  self.output.hideHistoryOutput(changeLabel: false)
            })

            topmenuHidden = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async() {
            print( "h:\(self.view.bounds.size.height)" )
            print( "w:\(self.view.bounds.size.width)" )
        }
        if UIDevice.current.orientation.isPortrait {
            if topmenuHidden {
                print("bool is true : \(topmenuHidden)")
                constraint.constant = 0
            } else {
                constraint.constant = view.bounds.width - 68
                print("constant height: \(-(view.bounds.width - outputView.bounds.width))")
            }
        } else if UIDevice.current.orientation.isLandscape {
            if topmenuHidden {
                constraint.constant = view.bounds.width - outputView.frame.width
            } else {
                constraint.constant =  view.frame.size.width - 68
            }
        }
    }
    
    
    
}
    
    




