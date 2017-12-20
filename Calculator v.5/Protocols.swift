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
    
}


protocol CalculatorInterface {
    func digit(_ value: String)
    func operation(_ operation: Operation)
    func function(_ function: Function)
    func utility(_ utility: Utility)
    func constants(_ constant: Constants)
    func allClean (_ cleen: Memory)
    func clear (_ clean: Memory)
    var resultClosure: ((Double?, Error?) -> ())? { get set }
}
