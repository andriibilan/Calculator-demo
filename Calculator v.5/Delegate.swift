//
//  Delegate.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/11/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

protocol InputInterface {
    func symbolPressed(_ symbol: String)
}

protocol InputInterfaceDelegate {
    func digitPressed(_ value: String)
    func operationPressed(_ operation: Operation)
    func functionPressed(_ function: Function)
    func utilityPressed(_ utility: Utility)
    func constantPressed(_ const: Constants)
    func allClean (_ clean: Memory)
    func display(_ symbol: String)
    func clear (_ clean: Memory)
}


