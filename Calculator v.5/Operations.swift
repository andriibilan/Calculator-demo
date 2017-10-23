//
//  Operations.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/20/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import Foundation
// MARK: Operations
enum Operation: String {
    case plus  = "+"
    case minus = "-"
    case mult  = "×"
    case div   = "÷"
    case exp   = "^"
    case percent = "%"
    case powTwo   = "^2"
}

enum Function: String {
    case sqrt    = "√"
    case sin     = "sin("
    case cos     = "cos("
    case tan     = "tan("
    case sinh    = "hsin("
    case cosh    = "hcos("
    case tanh    = "htan("
    case ln      = "ln("
    case lg      = "lg("
    case fact    = "!"
    case sign    = "+/-"
    case divOne = "1÷("
}

enum Memory: String {
    case allClean        = "C"
    case clear
}

enum Utility: String {
    case dot          = "."
    case leftBracket  = "("
    case rightBracket = ")"
    case equal = ""
}

enum Constants: String {
    case pi = "𝝿"
    case e  = "e"
}
