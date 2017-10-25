//
//  CalcBrain.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/11/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import Foundation

class CalcBrain  {
    var resultClosure: ((Double?, Error?) -> ())?
    var getValue : String = ""
    static  let shared = CalcBrain()
    private var inputDataArray = [String]()
    private var outputData = [String]()



// getValue get value after all cheking in CheckingTheCorrectInput
    func getValueAfterCheking (getValue : String) {
        self.getValue = getValue
       
    }
  
    private func seperateInputData(){ //function seperate inputData into math components
        inputDataArray = []
       // print("open separetadata string: \(getValue)")
        
        var l = true
        for ch in getValue.characters {
            if ch == "-" && l == true{
                inputDataArray.append("0")
            } else {
                l = false
            }
        }
        for charachter in getValue.characters {
            if isOperation(at: String(charachter)) {
                inputDataArray.append(String(charachter))
            } else if isValue(at: String(charachter)){ //determine if last charachter is number,
                if inputDataArray.count == 0 {         // if true add next charachter to the same string
                    inputDataArray.append(String(charachter))
                } else if isValue(at: inputDataArray[inputDataArray.count - 1])  {
                    inputDataArray[inputDataArray.count - 1] += String(charachter)
                } else {
                    inputDataArray.append(String(charachter)) //
                }
            } else if charachter == "." && !isOperation(at: inputDataArray[inputDataArray.count - 1]) {
                inputDataArray[inputDataArray.count - 1] += String(charachter)
            } else if  inputDataArray.count != 0 && !isTrigonomenry(at: inputDataArray[inputDataArray.count - 1]) && !isOperation(at: inputDataArray[inputDataArray.count - 1])  {
                inputDataArray[inputDataArray.count - 1] += String(charachter) // if element of array is not fully written trigonometry func
            } else {
                inputDataArray.append(String(charachter))
            }
        }
        //print(" close separedata: \(inputDataArray)")
    }




    private func calculateData(){  //calculate reverse polish notation
        outputData = []
        var stack = [String]() //stack for operators
        for symbol in inputDataArray{
            if !isOperation(at: symbol){ //if symbol is number
                outputData.append(String(symbol))
            } else if isOperationDM(at: String(symbol)){ //if symbol is math operation
                if stack.count == 0 || symbol == "(" { //if stack empty or symbol = (, add symbol
                    stack.append(String(symbol))
                } else if priorityBetweenOperators(first: stack.last!, second: symbol) &&  stack.last! != "(" {
                    //if last operator has higher or same precedence, pop element from stack to outputdata and push symbol
                    var i = 0
                    for element in stack.reversed() {
                        if priorityBetweenOperators(first: element, second: symbol) &&  element != "(" {
                            i+=1
                            outputData.append(String(element))
                        } else {
                            break
                        }
                    }
                    stack = Array(stack.dropLast(i))
                    stack.append(String(symbol))
                } else {
                    stack.append(String(symbol))
                }
            } else if symbol == ")" { //pop all elements until (
                var i = 0
                for element in stack.reversed() {
                    if element != "(" {
                        i += 1
                        outputData.append(String(element))
                    } else {
                        break
                    }
                }
                stack = Array(stack.dropLast(i+1))
            } else {
                stack.append(String(symbol))
            }
            //print("close calcdata:  \(outputData)")
            
        }
        for element in stack.reversed() {
            outputData.append(String(element))
        }
       // print("reversed outputdata calcdata:  \(outputData)")
        
    }
    private func priorityFor(char:String) -> Int{ //determine priority
        if char == "+" || char == "-"  {
            return 1
        } else if char == "^"  {
            return 3
        } else if   isTrigonomenry(at: char)  {
            return 4
        }
        return 2
    }
    
    private func priorityBetweenOperators(first:String, second:String) -> Bool { //priority between operators
        if priorityFor(char: first) >= priorityFor(char: second) {
            return true
        }
        return false
    }
    
    private func isValue(at char: String) -> Bool{// determine if number
        if let _ = Double(char) {
            return true
        }
        return false
    }
    
    private func isOperation(at char: String) -> Bool{ //determine if math symbol
        
        if isOperationDM(at: char) || char == "(" || char == ")"   {
            return true
        }
        return false
    }

    
    
    private func isTrigonomenry(at char: String) -> Bool{ //determine if trigonometry func
        if char == "sin"  || char == "cos" || char == "tan" || char == "√" || char == "%" || char == "hsin" || char == "hcos" || char == "htan" || char == "!" || char == "lg" || char == "ln" {
            return true
        }
        return false
    }
    
    private func isOperationDM(at char: String) -> Bool{ //determine if math operator
        
        if char == "+" || char == "÷" || char == "1÷" || char == "!" || char == "×" || char == "-" || char == "^" || char == "^2" || char == "√" || char == "hsin" || char == "hcos" || char == "htan" || char == "sin" || char == "cos" || char == "tan" || char == "%" || char == "lg" || char == "ln" {
            return true
        }
        return false
    }
    func CalculateRPN() -> Double { //calculate RPN and return result of expression
        self.seperateInputData()
        self.calculateData()
        var stack =  [Double]()
        for value in outputData {
            switch value {
            case "+":
                let rightValue = stack.removeLast()
                if stack.last != nil {
                    let leftValue = stack.removeLast()
                    stack.append(leftValue + rightValue)
                } else {
                    stack.append(rightValue)
                }
            case "-":
                let rightValue = stack.removeLast()
                if stack.last != nil {
                    let leftValue = stack.removeLast()
                    stack.append(leftValue - rightValue)
                } else {
                    stack.append(rightValue)
                }
            case "×":
                let rightValue = stack.removeLast()
                if stack.last != nil {
                    let leftValue = stack.removeLast()
                    stack.append(leftValue * rightValue)
                } else {
                    stack.append(rightValue)
                }
            case "%":
                let leftValue = stack.removeLast()
                if stack.last != nil {
                    let rightValue = stack.removeLast()
                    stack.append(((leftValue * rightValue)/100))
                } else {
                    stack.append(leftValue / 100)
                }
            case "÷":
                if stack.last != 0 {
                    let rightValue = stack.removeLast()
                    
                    if stack.last != nil {
                        let leftValue = stack.removeLast()
                        stack.append(leftValue / rightValue)
                    }
                    else {
                        stack.append(rightValue)
                    }
                }
            case "^":
                let rightValue = stack.removeLast()
                if stack.last != nil {
                    let leftValue = stack.removeLast()
                    stack.append(pow(leftValue, rightValue))
                } else {
                    stack.append(rightValue)
                }
            case "√":
                let value = stack.removeLast()
                stack.append(sqrt(value))
            case "lg":
                let value = stack.removeLast()
                stack.append(log10(value))
            case "ln":
                let value = stack.removeLast()
                stack.append(log(value))
            case "hcos":
                let value = stack.removeLast()
                stack.append(cosh(value))
            case "sin":
                let value = stack.removeLast()
                stack.append(sin(value))
            case "cos":
                let value = stack.removeLast()
                stack.append(cos(value))
            case "tan":
                let value = stack.removeLast()
                stack.append(tan(value))
            case "hsin":
                let value = stack.removeLast()
                stack.append(sinh(value))
            case "htan":
                let value = stack.removeLast()
                stack.append(tanh(value))
            case "!":
                let valueF = stack.removeLast()
                stack.append(factorial(valueF))
            case "1÷" :
                let leftValue = stack.removeLast()
                stack.append(1 / (Double)((leftValue)))
            default:
                stack.append( Double(value)!)
            }
          //  print("print stack after RPN:  \(stack)")
        }
        return stack[stack.count-1]
    }
    
    // function which calculate factorial
    func factorial (_ value: Double) -> Double {
        if value < 21{
            return value > 1 ? (value * factorial(value-1)) : 1.0
        } else {
            return Double.infinity
        }
    }
    
    
    
}





