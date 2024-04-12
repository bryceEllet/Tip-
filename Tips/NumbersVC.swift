//
//  NumbersVC.swift
//  Tips
//
//  Created by Bryce Ellet on 1/25/24.
//

import UIKit

class NumbersVC: UIViewController {

    @IBOutlet weak var amountLabel: UILabel!
    
    @IBAction func oneButtonPressed(_ sender: UIButton) {
        numberPressed(number: "1")
    }
    @IBAction func twoButtonPressed(_ sender: UIButton) {
        numberPressed(number: "2")
    }
    @IBAction func threeButtonPressed(_ sender: UIButton) {
        numberPressed(number: "3")
    }
    @IBAction func fourButtonPressed(_ sender: UIButton) {
        numberPressed(number: "4")
    }
    @IBAction func fiveButtonPressed(_ sender: UIButton) {
        numberPressed(number: "5")
    }
    @IBAction func sixButtonPressed(_ sender: UIButton) {
        numberPressed(number: "6")
    }
    @IBAction func sevenButtonPressed(_ sender: UIButton) {
        numberPressed(number: "7")
    }
    @IBAction func eightButtonPressed(_ sender: UIButton) {
        numberPressed(number: "8")
    }
    @IBAction func nineButtonPressed(_ sender: UIButton) {
        numberPressed(number: "9")
    }
    @IBAction func zeroButtonPressed(_ sender: UIButton) {
        if length > 0 {
            numberPressed(number: "0")
        }
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if numbers.count > 0 {
            numbers.remove(at: numbers.count-1)
            length = numbers.count
            updateScreen()
        }
        
    }
    @IBAction func enterButtonPressed(_ sender: UIButton) {
    }
    var length = 0
    var numbers: [String] = []
    var amount: Double = 0.00 {
        didSet {
            let newString = String(format: "$%.2f", amount)
            amountLabel.text = newString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    func numberPressed(number: String) {
        if length < 7 {
            numbers.append(number)
            length = numbers.count
            updateScreen()
        }
    }
    
    func updateScreen() {
        var front = ""
        var mid = ""
        var back = ""
        var counter = 0
        counter = length
        for number in numbers {
            if counter > 5 {
                front += number
            } else if counter > 2 {
                mid += number
            } else {
                if length == 1 {
                    back += "0"
                }
                back += number
            }
            counter -= 1
        }
        if back == "" {
            amount = 0.00
        } else if mid == "" {
            back = "0.\(back)"
            amount = Double(back)!
        } else if front == "" {
            mid = "\(mid).\(back)"
            amount = Double(mid)!
        } else {
            front = "\(front)\(mid).\(back)"
            amount = Double(front)!
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
