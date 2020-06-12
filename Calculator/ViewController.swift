//
//  ViewController.swift
//  Calculator
//
//  Created by WONG Ka Chun on 29/10/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit
import MathParser


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var equation: UITextField!
    @IBOutlet var ans: UILabel!
    @IBOutlet var monitor: UILabel!
    @IBOutlet var bar: UIToolbar!
    @IBOutlet var zero: UIButton!
    @IBOutlet var one: UIButton!
    @IBOutlet var two: UIButton!
    @IBOutlet var three: UIButton!
    @IBOutlet var four: UIButton!
    @IBOutlet var five: UIButton!
    @IBOutlet var six: UIButton!
    @IBOutlet var seven: UIButton!
    @IBOutlet var eight: UIButton!
    @IBOutlet var nine: UIButton!
    @IBOutlet var dot: UIButton!
    @IBOutlet var equal: UIButton!
    @IBOutlet var plus: UIButton!
    @IBOutlet var minus: UIButton!
    @IBOutlet var multiply: UIButton!
    @IBOutlet var divide: UIButton!
    @IBOutlet var open: UIButton!
    @IBOutlet var close: UIButton!
    @IBOutlet var percent: UIButton!
    @IBOutlet var sqroot: UIButton!
    @IBOutlet var delete: UIButton!
    @IBOutlet var clear: UIButton!
    var expression: String = ""
    var bracket: Int = 0
    var done: Bool = false
    

    
    @IBAction func equationChanged(_ sender: UITextField) {
        var valid: Bool = true
        for char in equation.text! {
            if char != "0" && char != "1" && char != "2" && char != "3" && char != "4" && char != "5" && char != "6" && char != "7" && char != "8" && char != "9" && char != "+" && char != "-" && char != "×" && char != "/" && char != "(" && char != ")" && char != "%" && char != "√" && char != "."{
                ans.text = "Invalid Input"
                valid = false
            }
        }
        if valid {
            if equation.text?.last == "0" || equation.text?.last == "1" || equation.text?.last == "2" || equation.text?.last == "3" || equation.text?.last == "4" || equation.text?.last == "5" || equation.text?.last == "6" || equation.text?.last == "7" || equation.text?.last == "8" || equation.text?.last == "9" || equation.text?.last == "%" {
                    expression = equation.text!
                    ans.text = computation(expression)
                
            }
        }
    }
    
    
    @IBAction func numbers(_ sender: UIButton) {
        //tag 0 - 9 for number 0 - 9 & tag 10 for decimal point
        var temp: String = ""
        if done == true {
            equation.text = ""
            done = false
        }
        if sender.tag != 10 {
            equation.text = equation.text! + String(sender.tag)
            expression = expression + String(sender.tag)
            if bracket != 0 {
                temp = expression
                for _ in 0..<bracket {
                    temp = temp + ")"
                }
                ans.text = computation(temp)
            } else {
                ans.text = computation(expression)
            }
        } else {
            equation.text = equation.text! + "."
            expression = expression + "."
        }
    }
    
    
    @IBAction func operators(_ sender: UIButton) {
        //tag 11:"=", 12:"+", 13:"-", 14:"×", 15:"/", 16:"(", 17:")", 18:"%", 19:"√"
        var temp: String = ""
        if done == true {
            equation.text = ""
            done = false
        }
        if sender.tag == 11{
            equation.text = ans.text
            ans.text = ""
            expression = ""
            done = true
        }
        if sender.tag == 12{
            
            if equation.text?.last == "-" || equation.text?.last == "×" || equation.text?.last == "/" || equation.text?.last == "(" || equation.text?.last == "." || equation.text?.last == "+" || equation.text == "" || equation.text?.last == "√" {
                ans.text = "Syntax Error"
            }
            equation.text = equation.text! + "+"
            expression = expression + "+"
        }
        if sender.tag == 13{
            if equation.text?.last == "+" || equation.text?.last == "×" || equation.text?.last == "/" || equation.text?.last == "." || equation.text?.last == "-" || equation.text?.last == "√" {
                ans.text = "Syntax Error"
            }
            equation.text = equation.text! + "-"
            expression = expression + "-"
        }
        if sender.tag == 14{
            if equation.text?.last == "+" || equation.text?.last == "-" || equation.text?.last == "/" || equation.text?.last == "(" || equation.text?.last == "." || equation.text?.last == "×" || equation.text == "" || equation.text?.last == "√" {
                ans.text = "Syntax Error"
            }
            equation.text = equation.text! + "×"
            expression = expression + "*"
        }
        if sender.tag == 15{
            if equation.text?.last == "-" || equation.text?.last == "×" || equation.text?.last == "/" || equation.text?.last == "(" || equation.text?.last == "." || equation.text?.last == "+" || equation.text!.last == "√" {
                ans.text = "Syntax Error"
            }
            equation.text = equation.text! + "/"
            expression = expression + "/"
        }
        if (sender.tag == 12 || sender.tag == 13 || sender.tag == 14 || sender.tag == 15){
            if bracket != 0 {
                temp = expression
                temp.removeLast(1)
                for _ in 0..<bracket {
                    temp = temp + ")"
                }
                ans.text = computation(temp)
            }
        }
        if sender.tag == 16{
            if equation.text?.last == "(" || equation.text?.last == "%" || equation.text?.last == "." {
                ans.text = "Syntax Error"
            }
            bracket = bracket + 1
            equation.text = equation.text! + "("
            expression = expression + "("
        }
        if sender.tag == 17{
            if bracket == 0 {
                equation.text = equation.text! + ")"
                expression =  expression + ")"
                ans.text = "Syntax Error"
            } else {
                if equation.text?.last == "-" || equation.text?.last == "×" || equation.text?.last == "/" || equation.text?.last == "(" || equation.text?.last == "+" || equation.text?.last == "." || equation.text?.last == "√" {
                    ans.text = "Syntax Error"
                    equation.text = equation.text! + ")"
                    expression = expression + ")"
                } else {
                    equation.text = equation.text! + ")"
                    temp = expression
                    for _ in 0..<bracket {
                        temp = temp + ")"
                    }
                    ans.text = computation(temp)
                    expression = expression + ")"
                    bracket = bracket - 1
                }
            }
        }
        if sender.tag == 18{
            if equation.text?.last == "-" || equation.text?.last == "×" || equation.text?.last == "/" || equation.text?.last == "(" || equation.text?.last == "%" || equation.text?.last == "." || equation.text?.last == "+" || equation.text == "" || equation.text?.last == "√" {
                ans.text = "Syntax Error"
            }
            equation.text = equation.text! + "%"
            expression = expression + "%"
            ans.text = computation(expression)
        }
        if sender.tag == 19{
            if equation.text?.last == "." {
                ans.text = "Syntax Error"
            }
            bracket = bracket + 1
            equation.text = equation.text! + "√("
            expression = expression + "sqrt("
        }
    }
    
    
    @IBAction func del(_ sender: UIButton) {
        // tag 20:Clear, tag 21:delete
        var temp: String = ""
        if sender.tag == 20 {
            equation.text = ""
            expression = ""
            ans.text = "0"
            bracket = 0
        } else {
            if expression != "" {
                equation.text?.removeLast(1)
                expression.removeLast(1)
                if equation.text == "+" || equation.text == "×" ||  equation.text == ")" || equation.text == "%" {
                    ans.text = "Syntax Error"
                } else if expression.last == "0" || expression.last == "1" || expression.last == "2" || expression.last == "3" || expression.last == "4" || expression.last == "5" || expression.last == "6" || expression.last == "7" || expression.last == "8" || expression.last == "9"{
                    ans.text = computation(expression)
                } else if expression == "" {
                    ans.text = "0"
                } else {
                    temp = expression
                    temp.removeLast()
                    ans.text = computation(temp)
                }
            }
        }
    }
    
    
    func computation(_ exp: String) -> String{
        var result: Double = 0
        let decimalFormatter = NumberFormatter()
        decimalFormatter.maximumFractionDigits = 15
        let set = OperatorSet(interpretsPercentSignAsModulo: false)
        do {
            let e = try Expression(string: exp, operatorSet: set)
            result = try Evaluator.default.evaluate(e)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        return decimalFormatter.string(for: result)!
    }
    
    
    @IBAction func changeStyle(_ sender: UIButton) {
        //tag 22:Sky Blue, tag 23:Classic, tag 24:IOS
        if sender.tag == 22 {
            colorChange(UIColor(red: 18.0/255.0, green: 118.0/255.0, blue: 255.0/255.0, alpha: 1.0), UIColor(red: 7.0/255.0, green: 62.0/255.0, blue: 163.0/255.0, alpha: 1.0), UIColor.white, UIColor(red: 184.0/255.0, green: 239.0/255.0, blue: 255.0/255.0, alpha: 1.0),UIColor(red: 103.0/255.0, green: 103.0/255.0, blue: 103.0/255.0, alpha: 1.0))
        }
        if sender.tag == 23 {
            colorChange(UIColor(red: 62.0/255.0, green: 62.0/255.0, blue: 62.0/255.0, alpha: 1.0), UIColor(red: 114.0/255.0, green: 114.0/255.0, blue: 114.0/255.0, alpha: 1.0), UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0), UIColor(red: 166.0/255.0, green: 192.0/255.0, blue: 133.0/255.0, alpha: 1.0),UIColor(red: 103.0/255.0, green: 103.0/255.0, blue: 103.0/255.0, alpha: 1.0))
        }
        if sender.tag == 24 {
            colorChange(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue:70.0/255.0, alpha: 1.0), UIColor.orange, UIColor.black, UIColor.black,UIColor.white)
        }
    }
    
    
    func colorChange (_ Number: UIColor, _ Operator: UIColor, _ Background: UIColor, _ Monitor: UIColor, _ Text: UIColor) {
        view.backgroundColor = Background
        bar.backgroundColor = Background
        monitor.backgroundColor = Monitor
        zero.backgroundColor = Number
        one.backgroundColor = Number
        two.backgroundColor = Number
        three.backgroundColor = Number
        four.backgroundColor = Number
        five.backgroundColor = Number
        six.backgroundColor = Number
        seven.backgroundColor = Number
        eight.backgroundColor = Number
        nine.backgroundColor = Number
        dot.backgroundColor = Number
        equal.backgroundColor = Number
        plus.backgroundColor = Operator
        minus.backgroundColor = Operator
        multiply.backgroundColor = Operator
        divide.backgroundColor = Operator
        open.backgroundColor = Operator
        close.backgroundColor = Operator
        percent.backgroundColor = Operator
        sqroot.backgroundColor = Operator
        delete.backgroundColor = Operator
        ans.textColor = Text
        equation.textColor = Text
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        equation.text = ans.text
        ans.text = ""
        expression = ""
        done = true
        textField.resignFirstResponder()
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        equation.delegate = self
    }


}

