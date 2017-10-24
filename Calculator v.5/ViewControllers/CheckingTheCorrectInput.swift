//
//  chekingTheCorrectInput.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/20/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import Foundation

class CheckingTheCorrectInput: NSObject, CalculatorInterface {
 
    
    
    static var outputController2 : OutputInterface?
   // var opertString: String = ""
    private  var calc = CalcBrain()
    var dotPressed = false
    var equalPressed = false
    var numberLeftBrackets = 0
    var numberRightBrackets = 0
    var myCurrentValue : String = ""
    
    
    func digit(_ value: String) {
        if equalPressed == true {
            CheckingTheCorrectInput.outputController2?.cleanLabel()
             CheckingTheCorrectInput.outputController2?.displayResult(value, operatorPressed: false)
            equalPressed = false
        } else {
            CheckingTheCorrectInput.outputController2?.displayResult(value, operatorPressed: false)
        }
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
            if lastValue != "" && lastValue != "(" && lastValue != "." && lastValue != "^" && lastValue != "√"{
                goodSymbol = Operation.plus.rawValue
                dotPressed = false
                equalPressed = false
                print("dot after operation \(dotPressed)")
            }
            
        case .minus:
            if lastValue != "." && lastValue != "√" && lastValue != "^" {
                goodSymbol = Operation.minus.rawValue
                dotPressed = false
                equalPressed = false
            }
            
        case .mult:
            if lastValue != "" && lastValue != "(" && lastValue != "." && lastValue != "%" && lastValue != "^" && lastValue != "√" {
                goodSymbol = Operation.mult.rawValue
                dotPressed = false
                equalPressed = false
            }
            
        case .div:
            if lastValue != "" && lastValue != "(" && lastValue != "." && lastValue != "%" && lastValue != "^" && lastValue != "√" {
                goodSymbol = Operation.div.rawValue
                dotPressed = false
                equalPressed = false
            }
            
        case .percent:
            if  lastValue != "" && lastValue != "." && lastValue != "(" {
                goodSymbol = Operation.percent.rawValue
            dotPressed = false
                equalPressed = false
            }
        case .exp:
            if lastValue != "" && lastValue != "." && lastValue != "("  {
                goodSymbol = Operation.exp.rawValue
            dotPressed = false
                equalPressed = false
            }
            
        case .powTwo:
            if !isCheckedForValueType(lastValue) && lastValue != "."{
                goodSymbol = Operation.powTwo.rawValue
            dotPressed = false
                equalPressed = false
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
        
        func addMissedRightBrackets () {
            var missedBrackets: String = ""
            var number = numberRightBrackets
            
            while numberLeftBrackets > number {
                missedBrackets += Utility.rightBracket.rawValue
                number += 1
            }
            CheckingTheCorrectInput.outputController2?.displayResult(missedBrackets, operatorPressed: false)
        }
        

        
        
        switch utility {
        case .leftBracket:
            if lastValue == "" || lastValue == "(" || isCheckedForValueType(lastValue) || lastValue == "^" || lastValue == "√"  {
                goodSymbol = Utility.leftBracket.rawValue
                numberLeftBrackets += 1
     
            }
            
        case .rightBracket:
            if lastValue != "" && lastValue != "(" && lastValue != "." && lastValue != "^" && lastValue != "√" && !isCheckedForValueType(lastValue) {
                goodSymbol = Utility.rightBracket.rawValue
                numberRightBrackets += 1
               
            }
 
        case .dot:
            if dotPressed == false{
                if lastValue != "." && !isCheckedForValueType(lastValue) && lastValue != "" && lastValue != "(" && lastValue != "%" && lastValue != "√" && lastValue != "^" && lastValue != "!"{
                    goodSymbol = Utility.dot.rawValue
                    dotPressed = true
                    print(dotPressed)
                }
            }

            
        case .equal:
            if equalPressed == false{
                if  myCurrentData.isEmpty  {
                    goodSymbol = ""
                    
                }else if  !isCheckedForValueType(lastValue) || lastValue == ")" {
                    goodSymbol = ""
                    addMissedRightBrackets()
                    pressEqual()
                    
                }
               
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
            if lastValue == "" || lastValue == "(" || isCheckedForValueType(lastValue) || lastValue == "√"{
                goodSymbol = function.rawValue
                numberLeftBrackets += 1
            }
        case .sqrt:
            if isCheckedForValueType(lastValue) || lastValue == "" || lastValue == "("{
                goodSymbol = function.rawValue
                numberLeftBrackets += 1
            }
        case .sinh , .cosh , .tanh :
            if lastValue == "" || lastValue == "(" || isCheckedForValueType(lastValue) {
                goodSymbol = function.rawValue
                numberLeftBrackets += 1
            }
        case .ln ,.lg :
            if lastValue == "" || lastValue == "(" || isCheckedForValueType(lastValue) {
                goodSymbol = function.rawValue
                numberLeftBrackets += 1
            }
        case .fact:
            if !isCheckedForValueType(lastValue) && lastValue != "." && lastValue != "" && lastValue != "("{
                goodSymbol = function.rawValue
            }

        case .divOne:
            if   isCheckedForValueType(lastValue) || lastValue == "" || lastValue == "("{
                goodSymbol = function.rawValue
                numberLeftBrackets += 1
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
            if isCheckedForValueType(lastValue) || lastValue == "" || lastValue == "(" || lastValue == "√" || lastValue == "^" {
                goodSymbol = "\(Double.pi)"
            }
        case .e:
            if isCheckedForValueType(lastValue) || lastValue == "" || lastValue == "(" || lastValue == "√" || lastValue == "^" {
                goodSymbol = "\(M_E)"
            }
            
        }
        
        CheckingTheCorrectInput.outputController2?.displayResult(goodSymbol, operatorPressed: false)
        
    }
    
    
    func pressEqual () {
        myCurrentValue = (CheckingTheCorrectInput.outputController2?.viewInDisplay())!
        calc.getValueAfterCheking(getValue: myCurrentValue)
        resultClosure?(calc.CalculateRPN(),nil)
        resetAllBrackets()
        equalPressed = true
    }
    
    
    func allClean(_ cleen: Memory) {
        CheckingTheCorrectInput.outputController2?.cleanLabel()
        calc.getValueAfterCheking(getValue: "")
        resetAllBrackets()
        dotPressed = false
        equalPressed = false
    }
    
    func clear (_ clean: Memory) {
        var myCurrentValue = (CheckingTheCorrectInput.outputController2?.viewInDisplay())!
        var updatedString = ""
        if clean == .clear {
          
            
            if myCurrentValue != "" {
                let str =  myCurrentValue.removeLast()
                if str == "." {
                    dotPressed = false
                    print("dot pressed after clear last : \(dotPressed)")
                }
                updatedString = myCurrentValue
                equalPressed = false
                CheckingTheCorrectInput.outputController2?.clearDisplay(updatedString)
            } else {
                myCurrentValue = ""
                CheckingTheCorrectInput.outputController2?.clearDisplay(myCurrentValue)
                print("empty String")
            }
        }
    }
    var resultClosure: ((Double?, Error?) -> ())?
    

    
    func resetAllBrackets() {
        
        numberLeftBrackets = 0
        numberRightBrackets = 0
    }
    
    
    func addMissedRightBrackets () -> String{
        var missedBrackets: String = ""
        var number = numberRightBrackets
        
        while numberLeftBrackets > number {
            missedBrackets += ")"
            number += 1
        }
        return missedBrackets
    }
    

   


}

extension String {
    
    func removeTrigonometryPartFromCurrentInput(_ input: String, forFunction function: Function) -> String {
        
        var updatedInput = input
        
        let rangeToDelete = updatedInput.range(of: "\(function)")
        updatedInput.removeSubrange(rangeToDelete!)
        
        return updatedInput
    }
    
}

