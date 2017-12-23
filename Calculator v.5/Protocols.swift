//
//  Protocols.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/13/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import Foundation


protocol OutputInterface {
    func displayResult(_ result: String, operatorPressed: Bool)
    func cleanLabel()
    func clearDisplay(_ resultAfterClear: String)
    func viewInDisplay() ->String
}

protocol HistoryProtocol {
    func getHistoryArray(equation: String, result: String)
    func deleteAllHistory()
}


protocol CalculatorInterface {
    func digit(_ value: String) -> Bool
    func operation(_ operation: Operation, lastValue: String) -> Bool
    func function(_ function: Function, lastValue: String) -> Bool
    func utility(_ utility: Utility, lastValue: String) -> Bool
    func constants(_ constant: Constants, lastValue: String) -> Bool
    func allClean (_ cleen: Memory)
    func clear (_ clean: Memory, equation: String) -> String
    var resultClosure: ((Double?, Error?) -> ())? { get set }
}


