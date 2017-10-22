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
        Label.text = ""
        
    }
    func clearDisplay(_ resultAfterClear: String){
        if  Label.text != nil{
          Label.text = resultAfterClear
        }else {
            Label.text = ""
        }
    }
    func viewInDisplay() -> String{
        return Label.text!
        
    }
    
    func displayResult(_ result: String, operatorPressed: Bool) {
        print("To display - \(result)")
        if Label.text == "" || operatorPressed == true {
            Label.text = result
        } else {
            Label.text! += result
        }
    }
    
    
    
    @IBOutlet weak var Label: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       CheckingTheCorrectInput.outputController2 = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
