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
    
    @IBAction func symbolPressed(_ sender: UIButton) {
        symbolPressed(sender.currentTitle!)
        animation(button: sender)
    }
    
    func animation(button: UIButton) {
        var currentColor = UIColor.init(red: 0/255.0, green: 204.0/255.0, blue: 68.0/255.0, alpha: 1)
        if UserDefaults.standard.bool(forKey: "checkGoodColor") == false {
            currentColor =  UIColor.init(red: 153.0/255.0, green: 38.0/255.0, blue: 0.0/255.0, alpha: 1)
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: { [button] in
            button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            button.backgroundColor = currentColor
           button.alpha = 1
            }, completion: { (final) in
                 button.transform = CGAffineTransform.identity
                button.alpha = 0.5
                button.backgroundColor = UIColor.init(red: 251.0/255.0, green: 227.0/255.0, blue: 223.0/255.0, alpha: 1)
        })
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(InputViewController.clear))//Tap function will call when user tap on button
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(InputViewController.allClear)) //Long function will call when user long press on button.
        tapGesture.numberOfTapsRequired = 1
        self.clearButton?.addGestureRecognizer(tapGesture)
        self.clearButton?.addGestureRecognizer(longGesture)
    }
    
    @objc func clear() {
        delegate?.clear(.clear)
    }

    @objc func allClear() {
        delegate?.allClean(.allClean)
    }
    
    // delegate for all symbols
    func symbolPressed(_ symbol: String) {
        switch symbol {
        case  "+" :
            delegate?.operationPressed(.plus)
        case "-" :
            delegate?.operationPressed(.minus)
        case "×" :
            delegate?.operationPressed(.mult)
        case "÷" :
            delegate?.operationPressed(.div)
        case "^" :
            delegate?.operationPressed(.exp)
        case "%" :
            delegate?.operationPressed(.percent)
        case "x²" :
            delegate?.operationPressed(.powTwo)
        case "(" :
            delegate?.utilityPressed(.leftBracket)
        case ")":
            delegate?.utilityPressed(.rightBracket)
        case ".":
            delegate?.utilityPressed(.dot)
        case "=" :
            delegate?.utilityPressed(.equal)
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
        case "sinh" :
            delegate?.functionPressed(.sinh)
        case "cosh" :
            delegate?.functionPressed(.cosh)
        case "tanh" :
            delegate?.functionPressed(.tanh)
        case "x!" :
            delegate?.functionPressed(.fact)
        case "𝝿" :
            delegate?.constantPressed(.pi)
        case "e" :
            delegate?.constantPressed(.e)
        case "1/x" :
            delegate?.functionPressed(.divOne)
        default:
            delegate?.digitPressed(symbol)
        }
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? InputViewController {
            destination.delegate = delegate
        }
    }
}
