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
    let defaults = UserDefaults.standard
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var outputView: UIView!
    @IBOutlet weak var inputDigitView: UIView!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    
    func currentData() -> String {
        let myCurrentData = output.currentTexTinDisplay()
        var lastValue = ""
        if !myCurrentData.isEmpty {
            lastValue = "\((myCurrentData.last)!)"
        }
        return lastValue
    }
    func colorForAnimation(isOperationGood: Bool) {
        if isOperationGood == true {
            defaults.set(true, forKey: "checkGoodColor")
        } else {
            defaults.set(false, forKey: "checkGoodColor")
        }
    }
    
    func clear(_ clean: Memory) {
        let equationAfterClear =  checkInput.clear(.clear, equation: output.currentTexTinDisplay())
        output.clearLast(value: equationAfterClear)
    }
    
    func allClean(_ clean: Memory) {
        checkInput.allClean(.allClean)
        output.cleanAll()
    }
    
    func digitPressed(_ value: String) {
        guard checkInput.digit(value) else {
            colorForAnimation(isOperationGood: true)
            return output.displayResults(value: value)
        }
        guard currentData() != ")" else {
            return colorForAnimation(isOperationGood: false)
        }
        colorForAnimation(isOperationGood: true)
        output.display(value: value, operatorPressed: false)
    }
    
    func operationPressed(_ operation: Operation) {
        if checkInput.isCheckedForValueType("\(currentData())") {
            var operatorPressAgain =  output.currentTexTinDisplay()
            operatorPressAgain.removeLast()
            output.displayResults(value: operatorPressAgain)
            colorForAnimation(isOperationGood: false)
        }
        guard  checkInput.operation(operation, lastValue: currentData()) else {
            return colorForAnimation(isOperationGood: false)
        }
        colorForAnimation(isOperationGood: true)
        output.display(value: operation.rawValue, operatorPressed: false)
    }
    
    func functionPressed(_ function: Function) {
        guard  checkInput.function(function, lastValue: currentData()) else {
            return colorForAnimation(isOperationGood: false)
        }
        output.display(value: function.rawValue, operatorPressed: false)
        colorForAnimation(isOperationGood: true)
    }
    
    func utilityPressed(_ utility: Utility) {
        guard checkInput.utility(utility, lastValue: currentData()) else {
            return colorForAnimation(isOperationGood: false)
        }
        output.display(value: utility.rawValue, operatorPressed: false)
        colorForAnimation(isOperationGood: true)
        if utility == Utility.equal {
            let brackets = checkInput.addMissedRightBrackets()
            output.display(value: brackets, operatorPressed: false)
            checkInput.pressEqual(equation: output.currentTexTinDisplay())
        }
    }
    
    func constantPressed(_ const: Constants) {
        guard checkInput.constants(const, lastValue: currentData()) else {
            return colorForAnimation(isOperationGood: false)
        }
        colorForAnimation(isOperationGood: true)
        guard const == Constants.pi else {
            return output.display(value: "\(M_E)", operatorPressed: false)
        }
        output.display(value: "\(Double.pi)", operatorPressed: false)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showButton.layer.roundCorners(corners: [.bottomRight, .bottomLeft], radius: 8, bounds: showButton.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkInput.resultClosure = { (value, eror) ->() in
            guard value != Double.infinity && value != -(Double.infinity) && !(value?.isNaN)! else {
                return self.errorPrint(value!)
            }
            guard value == nil else {
                return self.ifResultIsDouble(value!)
            }
        }
    }

    func errorPrint (_ val: Double) {
        let error = (String)(val)
        sendResultToDisplay(result: error)
    }
    
    func ifResultIsDouble(_ val: Double) { //verifing Double or Int
        if Double(Int64.max) > val {
            let value = (Int64)(val)
            let r  = val - (Double)(value)
            if r == 0 {
                let operation = String(value)
                sendResultToDisplay(result: operation)
                checkInput.dotPressed = false
            } else {
                let operation = (String)(val)
                sendResultToDisplay(result: operation)
                checkInput.dotPressed = true
            }
        } else {
            sendResultToDisplay(result: "value too large")
        }
    }
    
    func sendResultToDisplay(result: String) {
        let current = output.currentTexTinDisplay()
        output.getHistoryArray(equation: current, result: result)
        output.displayResults(value:  result)
    }
    
    var topmenuHidden: Bool = true
    @IBAction func showHistory(_ sender: Any) {
        print("check bool: \(topmenuHidden)")
        if topmenuHidden {
            constraint.constant = -(inputDigitView.bounds.maxY)
            self.output.hideHistoryOutput(changeLabel: true)
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            })
            topmenuHidden = false
        } else {
            constraint.constant = 15
            print(constraint.constant)
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                self.output.hideHistoryOutput(changeLabel: false)
            })
            topmenuHidden = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isPortrait {
            if topmenuHidden {
                constraint.constant = 15
            } else {
                constraint.constant =  -(view.bounds.width - 113)
            }
        } else {
            if topmenuHidden {
                constraint.constant = 15
            } else {
                constraint.constant = -(view.frame.size.width - 93)
            }
        }
    }
}
