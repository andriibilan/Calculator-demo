//
//  InputViewController.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/11/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//
import AVFoundation
import UIKit

class InputViewController: UIViewController, InputInterface {
    var delegate: InputInterfaceDelegate?
    

    func symbolPressed(_ symbol: String) {
        switch symbol {
        case "=" :
            delegate?.operationPressed(.equal)
        case  "+" :
            delegate?.operationPressed(.plus)
        case "-" :
            delegate?.operationPressed(.minus)
        case "x" :
            delegate?.operationPressed(.mult)
        case "÷" :
            delegate?.operationPressed(.div)
        case "^" :
            delegate?.operationPressed(.exp)
        case "%" :
            delegate?.operationPressed(.percent)
        
        default:
            delegate?.display(symbol)
        }
        
    }
    
    @IBAction func symbolPressed(_ sender: UIButton) {
        symbolPressed(sender.currentTitle!)
        func playClick() {
            AudioServicesPlaySystemSound(1104)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? InputViewController{
            destination.delegate = delegate
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.l
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//        if let _ = Function(rawValue: symbol){
//            delegate?.functionPressed(Function(rawValue: symbol)!)
//        } else if let _ = Operation(rawValue: symbol){
//            delegate?.operationPressed(Operation(rawValue: symbol)!)
//        } else if let _ = Utility(rawValue: symbol){
//            delegate?.utilityPressed(Utility(rawValue: symbol)!)
//        } else {
//                delegate?.digitPressed(symbol)
//            }
//


