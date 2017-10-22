//
//  chekingTheCorrectInput.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/20/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import Foundation

class CheckingTheCorrectInput: NSObject, CalculatorInterface {
 
    var opertString: String = ""
    
    static var outputController2 : OutputInterface?
    
      private  var calc = CalcBrain()
    
    func digit(_ value: String) {
   CheckingTheCorrectInput.outputController2?.displayResult(value, operatorPressed: false)
    }

    
    func isCheckedForValueType (_ value: String) -> Bool {
        switch value {
        case "+","-","×","÷":
            return true
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            return false
        default:
            return false
        }
    }
    
     func operation(_ operation: Operation) {
        
        var myCurrentData = (CheckingTheCorrectInput.outputController2?.viewInDisplay())!
        var goodSymbol = ""
        var lastValue = ""
        
        if !myCurrentData.isEmpty {
            lastValue = "\((myCurrentData.characters.last)!)"
            if isCheckedForValueType("\(lastValue)") {
                myCurrentData.removeLast()
                CheckingTheCorrectInput.outputController2?.displayResult(myCurrentData, operatorPressed: true)
            }
        }

        switch operation {
        case .plus:
            if lastValue != "" && lastValue != "(" && lastValue != "." {
                goodSymbol = Operation.plus.rawValue
            }

        case .minus:
            if lastValue != "." {
            goodSymbol = Operation.minus.rawValue
            }
            
        case .mult:
            if lastValue != "" && lastValue != "(" && lastValue != "." {
                goodSymbol = Operation.mult.rawValue
            }
            
        case .div:
            if lastValue != "" && lastValue != "(" && lastValue != "." {
                goodSymbol = Operation.div.rawValue
            }
            
        case .percent:
            if  lastValue != "" && lastValue != "." && lastValue != "(" {
                goodSymbol = Operation.percent.rawValue
            }
        case .exp:
            if lastValue != "" && lastValue != "." && lastValue != "("  {
                goodSymbol = Operation.exp.rawValue
            }
            
        case .divOne:
            if !isCheckedForValueType(lastValue){
                goodSymbol = operation.rawValue
            }
        }
        
        CheckingTheCorrectInput.outputController2?.displayResult(goodSymbol, operatorPressed: false)
    }
    
    func utility(_ utility: Utility) {
        
        var myCurrentData = (CheckingTheCorrectInput.outputController2?.viewInDisplay())!
        var goodSymbol = ""
        var lastValue = ""
        
        if !myCurrentData.isEmpty {
            lastValue = "\((myCurrentData.characters.last)!)"
            if isCheckedForValueType("\(lastValue)") {
                CheckingTheCorrectInput.outputController2?.displayResult(myCurrentData, operatorPressed: true)
            }
        }
        
        switch utility {
        case .leftBracket:
            if lastValue == "" || lastValue == "(" || isCheckedForValueType(lastValue) || lastValue == "^" {
                goodSymbol = Utility.leftBracket.rawValue
            }
            
        case .rightBracket:
            if lastValue != "" && lastValue != "(" && lastValue != "." && lastValue != "^" && !isCheckedForValueType(lastValue) {
                goodSymbol = Utility.rightBracket.rawValue
            }
            
        case .dot:
            if !isCheckedForValueType(lastValue) && lastValue != "." {
                goodSymbol = Utility.dot.rawValue
     
            }
            
        case .equal:
            if  myCurrentData.isEmpty  {
                goodSymbol = ""
                
            }else if  !isCheckedForValueType(lastValue) || lastValue == ")" {
                goodSymbol = ""
                pressEqual()
            }
            
        }
        
        CheckingTheCorrectInput.outputController2?.displayResult(goodSymbol, operatorPressed: false)
     
    }
    
    
    func function(_ function: Function) {
        var myCurrentData = (CheckingTheCorrectInput.outputController2?.viewInDisplay())!
        var goodSymbol = ""
        var lastValue = ""
        
        if !myCurrentData.isEmpty {
            lastValue = "\((myCurrentData.characters.last)!)"
            if isCheckedForValueType("\(lastValue)") {
                CheckingTheCorrectInput.outputController2?.displayResult(myCurrentData, operatorPressed: true)
            }
        }
        
        switch function {
        case .sin , .cos , .tan :
            if lastValue == "" || lastValue == "(" || isCheckedForValueType(lastValue) {
               goodSymbol = function.rawValue
            }
        case .sqrt:
            if isCheckedForValueType(lastValue) || lastValue == "" || lastValue == "("{
            goodSymbol = function.rawValue
            }
        case .sinh , .cosh , .tanh :
            if lastValue == "" || lastValue == "(" || isCheckedForValueType(lastValue) {
                goodSymbol = function.rawValue
            }
        case .ln ,.lg :
            if lastValue == "" || lastValue == "(" || isCheckedForValueType(lastValue) {
                goodSymbol = function.rawValue
            }
        case .fact:
            if !isCheckedForValueType(lastValue) && lastValue != "." && lastValue != "" && lastValue != "("{
                goodSymbol = function.rawValue
            }
        case .sign:
            if lastValue == "" || !isCheckedForValueType(lastValue){
                goodSymbol = ""
                
            }
        }
        
         CheckingTheCorrectInput.outputController2?.displayResult(goodSymbol, operatorPressed: false)
    }
    
    
    func constants(_ constant: Constants) {
        var myCurrentData = (CheckingTheCorrectInput.outputController2?.viewInDisplay())!
        var goodSymbol = ""
        var lastValue = ""
        
        if !myCurrentData.isEmpty {
            lastValue = "\((myCurrentData.characters.last)!)"
            if isCheckedForValueType("\(lastValue)") {
                CheckingTheCorrectInput.outputController2?.displayResult(myCurrentData, operatorPressed: true)
            }
        }
        switch constant {
        case .pi:
            if isCheckedForValueType(lastValue) || lastValue == "" || lastValue == "(" {
                goodSymbol = "\(Double.pi)"
            }
        case .e:
            if isCheckedForValueType(lastValue) || lastValue == "" || lastValue == "(" {
                goodSymbol = "\(M_E)"
            }

        }
         CheckingTheCorrectInput.outputController2?.displayResult(goodSymbol, operatorPressed: false)
        
    }

    
    func pressEqual () {
        let myCurrentValue = (CheckingTheCorrectInput.outputController2?.viewInDisplay())!
        calc.getValueAfterCheking(getValue: myCurrentValue)
         resultClosure?(calc.CalculateRPN(),nil)
    }

    
    func allClean(_ cleen: Memory) {
     CheckingTheCorrectInput.outputController2?.cleanLabel()
        calc.getValueAfterCheking(getValue: "")
    }
    
    func clear (_ clean: Memory) {
       var myCurrentValue = (CheckingTheCorrectInput.outputController2?.viewInDisplay())!
        var updatedString = ""
        if clean == .clear {
            if myCurrentValue != "" {
                myCurrentValue.removeLast()
                updatedString = myCurrentValue
                 CheckingTheCorrectInput.outputController2?.clearDisplay(updatedString)
            } else{
                myCurrentValue = ""
                CheckingTheCorrectInput.outputController2?.clearDisplay(myCurrentValue)
                print("empty String")
            }
        }
    }
    var resultClosure: ((Double?, Error?) -> ())?
    
  //  outputController?.clearDisplay(clearedString)

}


