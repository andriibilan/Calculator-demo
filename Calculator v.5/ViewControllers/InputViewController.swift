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
    
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(InputViewController.clear))//Tap function will call when user tap on button
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(InputViewController.allClear)) //Long function will call when user long press on button.
        tapGesture.numberOfTapsRequired = 1
       self.clearButton?.addGestureRecognizer(tapGesture)
       self.clearButton?.addGestureRecognizer(longGesture)
    }
    
    @objc func clear() {
        
        print("tap press")
    }
    
    @objc func allClear() {
        
        print("Long press")
    }
        // Do any additional setup after loading the view, typically from a nib.l
    func playClick() {
        AudioServicesPlaySystemSound(1106)
    }
    
    
    func symbolPressed(_ symbol: String) {
        switch symbol {
        case "=" :
            delegate?.utilityPressed(.equal)
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
        case "(" :
            delegate?.utilityPressed(.leftBracket)
        case ")":
            delegate?.utilityPressed(.rightBracket)
        case "tan" :
            delegate?.functionPressed(.tan)
        case "sin" :
            delegate?.functionPressed(.sin)
        case "cos" :
            delegate?.functionPressed(.cos)
        case "√" :
            delegate?.functionPressed(.sqrt)
        case "ln" :
            delegate?.functionPressed(.ln)
        case "lg" :
            delegate?.functionPressed(.lg)
        case "x!" :
            delegate?.functionPressed(.fact)
        case "+/-" :
            delegate?.functionPressed(.sign)
        case "snh" :
            delegate?.functionPressed(.sinh)
        case "cosh" :
            delegate?.functionPressed(.cosh)
        case "tanh" :
            delegate?.functionPressed(.tanh)
        case "𝝿" :
            delegate?.constantPressed(.pi)
        case "e" :
            delegate?.constantPressed(.e)
        
        default:
            delegate?.display(symbol)
        }
        
    }
    
    @IBAction func symbolPressed(_ sender: UIButton) {
        symbolPressed(sender.currentTitle!)
        playClick()
        
    }
    
  
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? InputViewController{
            destination.delegate = delegate
        }
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


