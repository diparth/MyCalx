//
//  ViewController.swift
//  MyCalx
//
//  Created by Diparth Patel on 6/15/17.
//  Copyright © 2017 Diparth Patel. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftCalc


var histories = [String]()


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
    
    var ref = DatabaseReference()
    
    
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
    
    @IBAction func dotPressed(_ sender: UIButton) {
        if !currentNumber.contains(".") {
            if currentNumber == "" {
                currentNumber = currentNumber + "0."
                displayLabel.text = currentNumber
                return
            }
            currentNumber = currentNumber + "."
            displayLabel.text = currentNumber
        }
        
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
                guard let lv = Double.init(leftVal) else {return}
                guard let rv = Double.init(rightVal) else {return}
                
                if op == Operations.Addition {
                    result = math.additionWith(leftVal: lv, rightVal: rv)
                    addToHistory("\(lv) + \(rv) = \(result)")
                }else if op == Operations.Subtract {
                    result = math.subtractWith(leftVal: lv, rightVal: rv)
                    addToHistory("\(lv) - \(rv) = \(result)")
                }else if op == Operations.Multiply {
                    result = math.multiplyWith(leftVal: lv, rightVal: rv)
                    addToHistory("\(lv) x \(rv) = \(result)")
                }else if op == Operations.Divide {
                    result = math.devide(leftVal: lv, By: rv)
                    addToHistory("\(lv) / \(rv) = \(result)")
                }
                
                
                leftVal = result
                displayLabel.text = result.refined
                
            }
            curOperator = op
            
        }else {
            leftVal = currentNumber
            currentNumber = ""
            if leftVal != "" {
                curOperator = op
            }
            
        }
        
    }
    
    
    func processTrigoWithOperator(_ op: Operations) {
        
        if currentNumber != "" {
            leftVal = currentNumber
        }
        
        if op == Operations.Sine && leftVal != ""{
            result = math.sineOf(value: Double.init(leftVal)!)
            addToHistory("Sine(\(leftVal)) = \(result)")
            leftVal = result
            currentNumber = result
            displayLabel.text = result
            
        }else if op == Operations.Cosine && leftVal != ""{
            result = math.cosineOf(value: Double.init(leftVal)!)
            addToHistory("Cos(\(leftVal)) = \(result)")
            leftVal = result
            currentNumber = result
            displayLabel.text = result
            
        }else if op == Operations.Tangent && leftVal != ""{
            result = math.tangentOf(value: Double.init(leftVal)!)
            addToHistory("Tan(\(leftVal)) = \(result)")
            leftVal = result
            currentNumber = result
            displayLabel.text = result
            
        }
    }
    
    func addToHistory(_ string: String) {
        if userDefaults.value(forKey: "HistoryEnabled") != nil {
            if userDefaults.bool(forKey: "HistoryEnabled") {
                histories.append(string)
                ref = Database.database().reference(withPath: "/")
                ref.updateChildValues(["history":histories])
            }
        }
    }
    

    
}


extension String {
    var refined: String {
        let tempStr = self.split(separator: ".")
        if  tempStr[1] == "0"{
            return self.replacingOccurrences(of: ".0", with: "")
        }
        return self
    }
}




