//
//  OutputViewController.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/11/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController, OutputInterface {
    
    func cleanLabel() {
        Label.text = "0"
    }
    func display(_ result: String){
        if Label.text == "0" {
            Label.text = result
        } else {
            Label.text = Label.text! + "\(result)"
        }
    }
    
    
    
    @IBOutlet weak var Label: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
