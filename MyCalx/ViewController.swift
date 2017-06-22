//
//  ViewController.swift
//  MyCalx
//
//  Created by Diparth Patel on 6/15/17.
//  Copyright © 2017 Diparth Patel. All rights reserved.
//

import UIKit
//import CoreCalculator
import SwiftCalc



class ViewController: UIViewController {
    
    
    enum Operations{
        case Addition
        case Subtract
        case Multiply
        case Divide
        case Sine
        case Cosine
        case Tangent
        case Equal
        case None
    }
    
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var userButton: UIButton!
    
    var currentNumber = ""
    var leftVal = ""
    var rightVal = ""
    var result = ""
    var curOperator = Operations.None
    var math = Math.init()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userButton.layer.cornerRadius = 25
        displayLabel.text = "0"

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //MARK: Operand button methods
    
    @IBAction func operandPressed(_ sender: UIButton) {
        currentNumber = currentNumber + "\(sender.tag)"
        displayLabel.text = currentNumber
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        
        curOperator = Operations.None
        currentNumber = ""
        leftVal = ""
        rightVal = ""
        displayLabel.text = "0"
        
    }
    
    //MARK: Operator button methods
    
    @IBAction func operatorPressed(_ sender: UIButton) {
        
        var tempOp = Operations.None
        
        if sender.titleLabel?.text == "+" {
            tempOp = Operations.Addition
        }else if sender.titleLabel?.text == "×" {
            tempOp = Operations.Multiply
        }else if sender.titleLabel?.text == "−" {
            tempOp = Operations.Subtract
        }else if sender.titleLabel?.text == "÷" {
            tempOp = Operations.Divide
        }else if sender.titleLabel?.text == "Sine" {
            tempOp = Operations.Sine
            processTrigoWithOperator(tempOp)
            return
        }else if sender.titleLabel?.text == "Cos" {
            tempOp = Operations.Cosine
            processTrigoWithOperator(tempOp)
            return
        }else if sender.titleLabel?.text == "Tan" {
            tempOp = Operations.Tangent
            processTrigoWithOperator(tempOp)
            return
        }else if sender.titleLabel?.text == "=" {
            tempOp = curOperator
        }
        
        processOperation(op: tempOp)
        
    }
    
    func processOperation(op: Operations){
        
        if curOperator != Operations.None {
            if currentNumber != "" {
                
                rightVal = currentNumber
                currentNumber = ""
                let lv = Double.init(leftVal)!
                let rv = Double.init(rightVal)!
                
                if op == Operations.Addition {
                    result = math.additionWith(leftVal: lv, rightVal: rv)
                }else if op == Operations.Subtract {
                    result = math.subtractWith(leftVal: lv, rightVal: rv)
                }else if op == Operations.Multiply {
                    result = math.multiplyWith(leftVal: lv, rightVal: rv)
                }else if op == Operations.Divide {
                    result = math.devide(leftVal: lv, By: rv)
                }
                
                
                leftVal = result
                displayLabel.text = result
                
            }
            curOperator = op
            
        }else {
            leftVal = currentNumber
            currentNumber = ""
            curOperator = op
            
        }
        
    }
    
    
    func processTrigoWithOperator(_ op: Operations) {
        
        if currentNumber != "" {
            leftVal = currentNumber
        }
        
        if op == Operations.Sine && leftVal != ""{
            result = math.sineOf(value: Double.init(leftVal)!)
            leftVal = result
            currentNumber = result
            displayLabel.text = result
            
        }else if op == Operations.Cosine && leftVal != ""{
            result = math.cosineOf(value: Double.init(leftVal)!)
            leftVal = result
            currentNumber = result
            displayLabel.text = result
            
        }else if op == Operations.Tangent && leftVal != ""{
            result = math.tangentOf(value: Double.init(leftVal)!)
            leftVal = result
            currentNumber = result
            displayLabel.text = result
            
        }
    }
    

    
}

