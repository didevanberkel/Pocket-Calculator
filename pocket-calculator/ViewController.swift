//
//  ViewController.swift
//  pocket-calculator
//
//  Created by Dide van Berkel on 20-02-16.
//  Copyright © 2016 Gary Grape Productions. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    var buttonSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("buttonClick", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(button: UIButton) {
        PlaySound()
        runningNumber += "\(button.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        ProcessOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        ProcessOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        ProcessOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        ProcessOperation(Operation.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        ProcessOperation(currentOperation)
    }
    
    @IBAction func onDotPressed(sender: AnyObject) {
        PlaySound()
        runningNumber += "."
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDeletePressed(sender: AnyObject) {
        PlaySound()
        runningNumber = ""
        rightValString = "0"
        leftValString = "0"
        outputLbl.text = runningNumber
    }
    
    func ProcessOperation(op: Operation){
        PlaySound()
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
            //Run the math
            rightValString = runningNumber
            runningNumber = ""
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValString)! * Double(rightValString)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValString)! / Double(rightValString)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValString)! - Double(rightValString)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValString)! + Double(rightValString)!)"
            }
            
            leftValString = result
            outputLbl.text = result
            }
            
            currentOperation = op
            
        } else {
            //This is the first time an operator is pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func PlaySound(){
        if buttonSound.playing {
            buttonSound.stop()
        }
        buttonSound.play()
    }


}

