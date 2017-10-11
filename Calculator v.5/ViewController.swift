//
//  ViewController.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/11/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, InputInterface {

    var outputController : OutputViewController? = nil
 
    func symbolPressed(_ symbol: String) {
        outputController?.display(symbol)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inputInfo"{
           let destinationVC = segue.destination as! InputViewController
            destinationVC.delegate = self
        } else if segue.identifier == "outputInfo"{
            outputController = segue.destination as?  OutputViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

