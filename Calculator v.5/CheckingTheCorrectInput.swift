//
//  chekingTheCorrectInput.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/20/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import Foundation

class CheckingTheCorrectInput: NSObject, CalculatorInterface {

    
    private  var calc = CalcBrain()
    private var equalPressed = false
    private var numberLeftBrackets = 0
    private var numberRightBrackets = 0
    var dotPressed = false
    
 // fuction for input digit
    func digit(_ value: String) -> Bool {
        guard equalPressed == true else {
            return true
        }
        equalPressed = false
        dotPressed = false
        return false
    }
    
 // fuction which return true for operation and false for digit
    func isCheckedForValueType (_ value: String) -> Bool {
        switch value {
        case "+","-","×","÷", "^":
            return true
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            return false
        default:
            return false
        }
    }
    
    func operation(_ operation: Operation, lastValue: String) -> Bool {
        switch operation {
        case .plus:
            if lastValue != "" && lastValue != "(" && lastValue != "."  && lastValue != "√"  {
                dotPressed = false
                equalPressed = false
                return true
            }
        case .minus:
            if lastValue != "." && lastValue != "√"  {
                dotPressed = false
                equalPressed = false
                return true
            }
        case .mult, .div, .exp , .powTwo:
            if lastValue != "" && lastValue != "(" && lastValue != "."  && lastValue != "√" {
                dotPressed = false
                equalPressed = false
                return true
            }
        case .percent:
            if   lastValue != "" && lastValue != "." && lastValue != "(" && lastValue != "%" {
                dotPressed = false
                equalPressed = false
                return true
            }
        }
        return false
    }
    
    func utility(_ utility: Utility, lastValue: String) -> Bool {
        switch utility {
        case .leftBracket:
            if lastValue == "" || lastValue == "(" || isCheckedForValueType(lastValue) || lastValue == "^" || lastValue == "√"  {
                numberLeftBrackets += 1
               return true
            }
//            else if !isCheckedForValueType(lastValue) {
//              //  goodSymbol = Operation.mult.rawValue + Utility.leftBracket.rawValue
//                numberLeftBrackets += 1
//            }
            
        case .rightBracket:
            if lastValue != "" && lastValue != "(" && lastValue != "." && lastValue != "^" && lastValue != "√" && !isCheckedForValueType(lastValue) {
                numberRightBrackets += 1
                return true
            }
        case .dot:
            if dotPressed == false {
                if lastValue != "." && !isCheckedForValueType(lastValue) && lastValue != "" && lastValue != "(" && lastValue != "%" && lastValue != "√" && lastValue != "^" && lastValue != "!" {
                    dotPressed = true
                    return true
                }
            }
        case .equal:
            if equalPressed == false {
                print(!isCheckedForValueType(lastValue) )
                if  lastValue.isEmpty  {
                   return false
                } else if lastValue == "(" {
                    return false
                }  else if  !isCheckedForValueType(lastValue) || lastValue == ")" {
                    return true
                }
            }
        }
        return false
    }
    
    func function(_ function: Function, lastValue: String) -> Bool {
 // check the correct input oparation
        switch function {
        case .sin , .cos , .tan, .sqrt, .sinh, .cosh, .tanh, .ln, .lg, .divOne :
            if lastValue == "" || lastValue == "(" || isCheckedForValueType(lastValue) {
                numberLeftBrackets += 1
                return true
            }
        case .fact:
            if !isCheckedForValueType(lastValue) && lastValue != "." && lastValue != "" && lastValue != "(" {
                return true
            }
        }
        return false
    }
    
    func constants(_ constant: Constants, lastValue: String) -> Bool {
        switch constant {
        case .pi, .e:
            if isCheckedForValueType(lastValue) || lastValue == "" || lastValue == "(" || lastValue == "√" || lastValue == "^" {
                return true
            }
        }
        return false
    }
    
    func addMissedRightBrackets () -> String {
        var missedBrackets: String = ""
        var number = numberRightBrackets
        while numberLeftBrackets > number {
            missedBrackets += Utility.rightBracket.rawValue
            number += 1
        }
        return missedBrackets
    }
    
// do some work after press equal
    func pressEqual(equation: String) {
        calc.getValueAfterCheking(getValue: equation)
        resultClosure?(calc.CalculateRPN(),nil)
        resetAllBrackets()
        equalPressed = true
    }
    
// Clean all elemets
    func allClean(_ cleen: Memory) {
        calc.getValueAfterCheking(getValue: "")
        resetAllBrackets()
        dotPressed = false
        equalPressed = false
    }
    
// Clean last elemet
    func clear (_ clean: Memory, equation: String) -> String {
        var myCurrentValue = equation
        var updatedString = ""
        var str: Character?
        if clean == .clear { 
            if myCurrentValue != "" {
                if myCurrentValue.suffix(2) == "s(" || myCurrentValue.suffix(2) == "n(" || myCurrentValue.suffix(2) == "g(" {
                    myCurrentValue = deleteTrigonometry(str: myCurrentValue)
                } else {
                    str = myCurrentValue.removeLast()
                }
                if str == "." {
                    dotPressed = false
                }
                updatedString = myCurrentValue
                equalPressed = false
                return updatedString
            }
            equalPressed = false
        }
        return myCurrentValue
    }
    
    var resultClosure: ((Double?, Error?) -> ())?
    
    
// reset all number of brackets
    func resetAllBrackets() {
        numberLeftBrackets = 0
        numberRightBrackets = 0
    }
 
    func deleteTrigonometry(str: String) -> String {
        if str.suffix(3) == "lg(" || str.suffix(3) == "ln(" {
            return delete(string: str, deleteOfNumbers: 3)
        } else if  str.suffix(5) == "hcos(" || str.suffix(5) == "hsin(" || str.suffix(5) == "htan(" {
            return delete(string: str, deleteOfNumbers: 5)
        } else {
            return delete(string: str, deleteOfNumbers: 4)
        }
    }
    
    func delete(string: String, deleteOfNumbers: Int) -> String {
        let range1 = string.dropLast(deleteOfNumbers)
        return String(range1)
    }
}


