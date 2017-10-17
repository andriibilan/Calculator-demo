//
//  CalcBrain.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/11/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import Foundation


    


// MARK: Operations
enum Operation: String {
    case plus  = "+"
    case minus = "-"
    case mult  = "x"
    case div   = "÷"
    case exp   = "^"
    case equal = "="
    case percent = "%"
}

enum Function: String {
    case sqrt    = "√"
    case sin     = "sin"
    case cos     = "cos"
    case tan     = "tan"
    case sinh    = "sinh"
    case cosh    = "cosh"
    case tanh    = "tanh"
    case ln      = "ln"
    case lg      = "lg"
    case log     = "log"
    case fact    = "x!"
    case sign    = "+/-"
}

enum Memory: String {
    case memoryClean  = "mc"
    case memoryAdd    = "m+"
    case memoryRemove = "m-"
    case clean        = "C"
    case allClean     = "AC"
}

enum Utility: String {
    case dot          = "."
    case leftBracket  = "("
    case rightBracket = ")"
}

enum Constants: String {
    case pi = "π"
    case e  = "e"
}
protocol OutputInterface {
    func display(_ result: String)
}

    protocol CalculatorInterface {
        func digit(_ value: Double)
        func operation(_ operation: Operation)
        func function(_ function: Function)
        func memory(_ memory: Memory)
        func utility(_ utility: Utility)
        var resultClosure: ((Double?, Error?) -> ())? { get set }
    }


class CalcBrain : CalculatorInterface {
    var resultClosure: ((Double?, Error?) -> ())?
    var opertString = ""
    private var openBrackets = 0
   static let shared = CalcBrain()
    private var inputDataArray = [String]()
    private var outputData = [String]()
    
    func digit(_ value: Double) {
        opertString = opertString + (String)(value)
    }
    
    
    func operation(_ operation: Operation) {
        if operation == .plus {
           if opertString == "0" || opertString == "" || ( opertString.characters.count == 1 && opertString.characters.last == "-" ){
                opertString = "+"
           }
            else if (opertString.characters.last == ")" || opertString.characters.last! >= "0" && opertString.characters.last! <= "9") || opertString.characters.last == "."{
                opertString = opertString + " +"
            }else if opertString.characters.last != "("{
                opertString.characters.removeLast()
                opertString = opertString + "+"
            }
        }else if operation == .minus {
            if opertString == "0" || opertString == "" || ( opertString.characters.count == 1 && opertString.characters.last == "+" ){
                opertString = "-"
            }else if (opertString.characters.last == ")" || opertString.characters.last! >= "0" && opertString.characters.last! <= "9") || opertString.characters.last == "."{
                opertString = opertString + " -"
            }else if opertString.characters.last != "("{
                opertString.characters.removeLast()
                opertString = opertString + "-"
            }
        }else if operation == .mult{
            if  opertString.characters.count > 0 {
                if (opertString.characters.last! >= "0" && opertString.characters.last! <= "9") || opertString.characters.last == ")" || opertString.characters.last! == "."{
                    opertString = opertString + " ×"
                }else if opertString.characters.last != "(" && opertString != "+" && opertString != "-"{
                    opertString.removeLast()
                    opertString = opertString + "×"
                }
            }
        } else if operation == .div{
            if  opertString.characters.count > 0 {
                if (opertString.characters.last! >= "0" && opertString.characters.last! <= "9") || opertString.characters.last == ")" || opertString.characters.last! == "."{
                    opertString = opertString + " ÷"
                }else if opertString.characters.last != "(" && opertString != "+" && opertString != "-"{
                    opertString.removeLast()
                    opertString = opertString + "÷"
                }
            }
        } else if operation == .exp{
            if opertString.characters.count > 0 {
                if (opertString.characters.last! >= "0" && opertString.characters.last! <= "9") || opertString.characters.last == ")" || opertString.characters.last! == "."{
                    opertString = opertString + " ^"
                } else if opertString.characters.last != "(" && opertString != "+" && opertString != "-"{
                    opertString.removeLast()
                    opertString = opertString + "^"
                }
                
            }
        }
        else if operation == .equal  {
            if ( opertString != "0" && opertString != "") && ( opertString.characters.last! >= "0" && opertString.characters.last! <= "9") || opertString.characters.last == ")"{
                resultClosure?(CalculateRPN(),nil)
                inputDataArray = [String]()
                outputData = [String]()
            }
        
        }
    }
    

    func function(_ function: Function) {
        
    }
    
    func memory(_ memory: Memory) {
        
    }
    
    func utility(_ utility: Utility) {
        if utility == .dot {
            if opertString  == "0" || opertString == "" {
                opertString = "0."
            } else if opertString.characters.last != "."{
                if opertString.characters.last! >= "0" && opertString.characters.last! <= "9"{
                    opertString = opertString + "."
                } else if opertString.characters.last == "(" {
                    opertString = opertString + "0."
                }
            }
        }else if utility == .leftBracket {
            if opertString  == "0" || opertString == "" {
                opertString = "("
            }else if opertString.characters.last! >= "0" && opertString.characters.last! <= "9" || opertString.characters.last! == ")" {
                opertString = opertString + " × ( "
            } else {
                opertString = opertString + " ("
            }
        }else if utility == .rightBracket{
            if ( opertString != "0" && opertString != "" ) && opertString.characters.last != "(" {
                if opertString.characters.last! >= "0" && opertString.characters.last! <= "9" {
                    opertString = opertString + ")"
                }else {
                    opertString = opertString + ")"
                }
            }
            
        }
    }
    
    private func seperateInputData(){ //function seperate inputData into math components
        print(opertString)
        var l = true
        for ch in opertString.characters {
            if ch == "-" && l == true{
                inputDataArray.append("0")
            } else {
                l = false
            }
        }
        for charachter in opertString.characters {
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
            } else if charachter == "." {
                inputDataArray[inputDataArray.count - 1] += String(charachter)
            } else if inputDataArray.count != 0 && !isTrigonomenry(at: inputDataArray[inputDataArray.count - 1]) && !isOperation(at: inputDataArray[inputDataArray.count - 1]) {
                inputDataArray[inputDataArray.count - 1] += String(charachter) // if element of array is not fully written trigonometry func
            } else {
                inputDataArray.append(String(charachter))
            }
        }
        print(inputDataArray)
    }

    private func calculateData(){  //calculate reverse polish notation
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
            print(outputData)
            print(stack)

        }
        for element in stack.reversed() {
            outputData.append(String(element))
        }
        print(outputData)

    }
    private func priorityFor(char:String) -> Int{ //determine priority
        if char == "+" || char == "-" {
            return 1
        } else if (char == "^") {
            return 3
        } else if isTrigonomenry(at: char) {
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
        if char >= "0" && char <= "9" {
            return true
        }
        return false
    }

    private func isOperation(at char: String) -> Bool{ //determine if math symbol

        if isOperationDM(at: char) || char == "(" || char == ")" {
            return true
        }
        return false
    }

    private func isTrigonomenry(at char: String) -> Bool{ //determine if trigonometry func
        if char=="sin" || char=="cos" || char=="tg" || char=="ctg" {
            return true
        }
        return false
    }

    private func isOperationDM(at char: String) -> Bool{ //determine if math operator

        if char=="+" || char=="/" || char == "*" || char=="-" || char == "^" || char == "sin" || char == "cos" || char == "tg" || char == "ctg" {
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
                let leftValue = stack.removeLast()
                stack.append(leftValue + rightValue)
            case "-":
                let rightValue = stack.removeLast()
                let leftValue = stack.removeLast()
                stack.append(leftValue - rightValue)
            case "*":
                let rightValue = stack.removeLast()
                let leftValue = stack.removeLast()
                stack.append(leftValue * rightValue)
            case "/":
                let rightValue = stack.removeLast()
                let leftValue = stack.removeLast()
                stack.append(leftValue / rightValue)
            case "^":
                let rightValue = stack.removeLast()
                let leftValue = stack.removeLast()
                stack.append(pow(leftValue, rightValue))
            case "sin":
                let value = stack.removeLast()
                stack.append(sin(value))
            case "cos":
                let value = stack.removeLast()
                stack.append(cos(value))
            case "tg":
                let value = stack.removeLast()
                stack.append(tan(value))
            case "ctg":
                let value = stack.removeLast()
                stack.append(1/tan(value))


            default:
                stack.append( Double(value)!)
            }
            print(stack)
        }
        return stack[stack.count-1]
    }
   
    
    
    
    
    //function for calc my expression after pressed =
//    func PerformOperation()->String{
//        if  openBrackets == 0{
//            opertString = Decimalpoint(CalculatePostfixNotation(expression: opertString))
//        }
//        return opertString
//    }
//
//    //function witch return resalt in int or double
//    func Decimalpoint(_ doubleValue:Double)->String{
//        let intValue=Int(doubleValue)
//        if doubleValue != Double(intValue){
//            return String(doubleValue)
//        }else{
//            return String(intValue)
//        }
//    }
//
//
//    // function for calculation my expression
//    func CalculatePostfixNotation (expression str: String)->Double{
//        let rpn = ReversePolandNotation(tokens: StringSeparator(str))
//        var stack: [String] = [] // store digit
//        for token in rpn{
//            if Double(token) != nil{
//                stack += [token]
//            }else if !stack.isEmpty && (token == Function.cos.rawValue  || token == Function.ln.rawValue || token == Function.lg.rawValue || token == Function.sin.rawValue || token == Function.tan.rawValue || token == Function.sqrt.rawValue  ){
//                if let operand = Double(stack.removeLast()){
//                    switch token{
//                    case Function.cos.rawValue: stack += [String(cos(operand))]
//                    //    case Factorial.fact.rawValue: stack += [String(Facrotial(value: Int(operand)))]
//                    case Function.ln.rawValue: stack += [String(log(operand))]
//                    case Function.lg.rawValue: stack += [String(log10(operand))]
//                    case Function.sin.rawValue: stack += [String(sin(operand))]
//                    case Function.tan.rawValue: stack += [String(tan(operand))]
//                    case Function.sqrt.rawValue: stack += [String(sqrt(operand))]
//                    default:break
//                    }
//                }
//            }else{
//                if stack.count > 1 {
//                    if let secondOperand = Double(stack.removeLast()), let firstOperand = Double(stack.removeLast()){
//                        switch token{
//                        case Operation.percent.rawValue: stack += [String(Int(firstOperand) % Int(secondOperand))]
//                        case Operation.plus.rawValue: stack += [String(firstOperand + secondOperand)]
//                        case Operation.minus.rawValue: stack += [String(firstOperand - secondOperand)]
//                        case Operation.div.rawValue: stack += [String(firstOperand / secondOperand)]
//                        case Operation.mult.rawValue: stack += [String(firstOperand * secondOperand)]
//                        case Operation.exp.rawValue: stack += [String(pow(firstOperand , secondOperand))]
//                        default: break
//                        }
//                    }
//                }else{
//                    return 0.0
//                }
//            }
//        }
//        return Double(stack.removeLast())!
//    }
//
//    // function for reverse my function
//    func ReversePolandNotation(tokens:[String])->[String]{
//        var rpn : [String]   = [] // buffer for expression
//        var stack : [String] = [] // buffer for operation
//
//        //prioritise my operations
//        let operationPriority : Dictionary <String,Int> = [
//            Operation.plus.rawValue:2,
//            Operation.minus.rawValue:2,
//            Operation.mult.rawValue:3,
//            Operation.div.rawValue:3,
//            Operation.exp.rawValue:4,
//            Function.lg.rawValue:4,
//            Function.ln.rawValue:4,
//            Function.cos.rawValue:5,
//            Function.sin.rawValue:5,
//            Function.tan.rawValue:5,
//            Function.sqrt.rawValue:5,
//            //Factorial.fact.rawValue:6,
//            Operation.percent.rawValue:3,
//            ]
//
//        //filling rpn-array and drop brackets
//
//        for token in tokens{
//            switch token{
//            case Utility.leftBracket.rawValue: stack += [token]
//            case Utility.rightBracket.rawValue:
//                while !stack.isEmpty{
//                    let temp = stack.removeLast()
//                    if temp == Utility.leftBracket.rawValue{
//                        break
//                    }else{
//                        rpn += [temp]
//                    }
//                }
//            default:
//                if let firstOperand = operationPriority[token]{
//                    for temp in stack.reversed(){
//                        if let secondOperand = operationPriority[temp], !(firstOperand > secondOperand){
//                            rpn += [stack.removeLast()]
//                            continue
//                        }
//                        break;
//                    }
//                    stack += [token]
//                }else{
//                    rpn += [token]
//                }
//            }
//        }
//        return (rpn+stack.reversed())
//    }
//
//    //string by characters
//    func StringSeparator(_ equationStr: String) -> [String] {
//        let tokens = equationStr.characters.split{ $0 == " " }.map(String.init)
//        return tokens
//    }
//
//    // MARK: Protocols
    
}





