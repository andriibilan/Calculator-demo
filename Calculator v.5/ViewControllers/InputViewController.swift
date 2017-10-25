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
  // make two fuction for one button
        
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
    

        // Do any additional setup after loading the view, typically from a nib.l
    func playClick() {
        AudioServicesPlaySystemSound(1106)
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
        case "x^2" :
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
    @IBAction func symbolPressed(_ sender: UIButton) {
        symbolPressed(sender.currentTitle!)
        playClick()
       sender.pulseButton()
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

// Make animation for button
extension UIButton {
    func pulseButton(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 7, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 7, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        layer.add(animation, forKey: nil)
    }
}

