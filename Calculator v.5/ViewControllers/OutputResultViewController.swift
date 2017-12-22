//
//  OutputResultViewController.swift
//  Calculator v.5
//
//  Created by andriibilan on 12/19/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class OutputResultViewController: UIViewController, OutputInterface {
    @IBOutlet weak var Label: UILabel!
    
    // output result in display
    func displayResult(_ result: String, operatorPressed: Bool) {
        if Label.text == "" || operatorPressed == true {
            Label.text = result
        } else {
            Label.text! += result
        }
    }
    
    //  clean all elemets
    func cleanLabel() {
        Label.text = ""
    }
    
    // use for output result after clean last element
    func clearDisplay(_ resultAfterClear: String) {
        if  Label.text != nil {
            Label.text = resultAfterClear
        } else {
            Label.text = ""
        }
    }
    
    // current view in display
    func viewInDisplay() -> String {
        return Label.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckingTheCorrectInput.outputController2 = self
    }
}
