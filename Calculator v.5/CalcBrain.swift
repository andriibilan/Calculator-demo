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
    case div   = "/"
    case exp   = "^"
    case equal = "="
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
    case log     = "log"
    case fact    = "x!"
    case percent = "%"
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

// MARK: Protocols



protocol OutputInterface {
    func display(_ result: String)
}

protocol CalculatorInterface {
    func digit(_ value: Double)
    func operation(_ operation: Operation)
    func function(_ function: Function)
    func memory(_ memory: Memory)
    func utility(_ utility: Utility)
    var resultClosure: ((Double?, Error?) -> Void) { get set }
}
