//
//  ViewController.swift
//  Tips
//
//  Created by Bryce Ellet on 1/22/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var billAmountLabel: UIButton!
    @IBOutlet weak var tipAmountLabel: UIButton!
    @IBOutlet weak var eachPayLabel: UIButton!
    @IBOutlet weak var totalBillLabel: UIButton!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    
    @IBOutlet weak var badFace: UIButton!
    @IBOutlet weak var ehFace: UIButton!
    @IBOutlet weak var goodFace: UIButton!
    
    @IBAction func badFaceButton(_ sender: UIButton) {
        percent = 10
        changeImages(face: 1)
    }
    @IBAction func ehFaceButton(_ sender: UIButton) {
        percent = 15
        changeImages(face: 2)
    }
    @IBAction func goodFaceButton(_ sender: UIButton) {
        percent = 20
        changeImages(face: 3)
    }
    @IBAction func percentLeftButton(_ sender: UIButton) {
        percent -= 1
    }
    @IBAction func percentRightButton(_ sender: UIButton) {
        percent += 1
    }
    @IBAction func roundingSettingsButton(_ sender: UIButton) {
    }
    @IBAction func tipRoundingButton(_ sender: UIButton) {
        if rounding == 0 {
            rounding = roundingOptions
        } else {
            rounding = 0
        }
        roundWhat = 0
        doMath()
    }
    @IBAction func peopleLeftButton(_ sender: UIButton) {
        people -= 1
    }
    @IBAction func peopleRightButton(_ sender: UIButton) {
        people += 1
    }
    @IBAction func peopleRoundingButton(_ sender: UIButton) {
        if rounding == 0 {
            rounding = roundingOptions
        } else {
            rounding = 0
        }
        roundWhat = 1
        doMath()
    }
    @IBAction func totalRoundingButton(_ sender: UIButton) {
        if rounding == 0 {
            rounding = roundingOptions
        } else {
            rounding = 0
        }
        roundWhat = 2
        doMath()
    }
    @IBAction func resetButton(_ sender: UIButton) {
        billAmount = 0.00
        doMath()
    }
    
    var billAmount = 0.00 {
        didSet {
            let newString = String(format: "$%.2f", billAmount)
            billAmountLabel.setTitle(newString, for: .normal)
            doMath()
        }
    }
    var percent = 15 {
        didSet {
            if percent < 1 {
                percent = 1
            } else if percent > 99 {
                percent = 99
            }
            percentLabel.text = "\(percent)%"
            switch percent {
            case 10:
                changeImages(face: 1)
            case 15:
                changeImages(face: 2)
            case 20:
                changeImages(face: 3)
            default:
                print("")
            }
            doMath()
        }
    }
    var people = 1 {
        didSet {
            if people < 1 {
                people = 1
            } else if people > 99 {
                people = 99
            }
            peopleLabel.text = "\(people)"
            doMath()
        }
    }
    var tipAmount: Double = 15.00 {
        didSet {
            let newString = String(format: "$%.2f", tipAmount)
            tipAmountLabel.setTitle(newString, for: .normal)
        }
    }
    var eachPays = 15.00 {
        didSet {
            let newString = String(format: "$%.2f", eachPays)
            eachPayLabel.setTitle(newString, for: .normal)
        }
    }
    var totalBill = 0.00 {
        didSet {
            let newString = String(format: "$%.2f", totalBill)
            totalBillLabel.setTitle(newString, for: .normal)
        }
    }
    var roundWhat = -1 // 0 = tip, 1 = people, 2 = total
    var rounding = 0 // 1 = 1.00, 2 = 0.10
    var roundingOptions = 1 // changes with settings
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let numbersVC = segue.source as! NumbersVC
        let newValue: Double = numbersVC.amount
        if newValue == numbersVC.amount {
            billAmount = newValue
        }
    }

    func doMath() {
        doTip()
        doTotal()
        splitBill()
    }
    
    func doTip() {
        tipAmount = (Double(percent)/100)*billAmount
        if roundWhat == 0 {
            if rounding == 1 {
                tipAmount.round()
            } else if rounding == 2 {
                tipAmount *= 10
                tipAmount.round()
                tipAmount /= 10
            }
        }
    }
    
    func doTotal() {
        totalBill = billAmount + tipAmount
        if roundWhat == 2 {
            if rounding == 1 {
                totalBill.round()
            } else if rounding == 2 {
                totalBill *= 10
                totalBill.round()
                totalBill /= 10
            }
        }
    }
    
    func splitBill() {
        eachPays = totalBill/Double(people)
        if roundWhat == 1 {
            if rounding == 1 {
                eachPays.round()
            } else if rounding == 2 {
                eachPays *= 10
                eachPays.round()
                eachPays /= 10
            }
            totalBill = eachPays * Double(people)
        }
    }
    
    func changeImages(face: Int) {
        switch face {
        case 1:
            badFace.setImage(UIImage(named: "sadx.png"), for: .normal)
            ehFace.setImage(UIImage(named: "shy1x.png"), for: .normal)
            goodFace.setImage(UIImage(named: "happy1x.png"), for: .normal)
        case 3:
            badFace.setImage(UIImage(named: "sad1x.png"), for: .normal)
            ehFace.setImage(UIImage(named: "shy1x.png"), for: .normal)
            goodFace.setImage(UIImage(named: "happyx.png"), for: .normal)
        default:
            badFace.setImage(UIImage(named: "sad1x.png"), for: .normal)
            ehFace.setImage(UIImage(named: "shyx.png"), for: .normal)
            goodFace.setImage(UIImage(named: "happy1x.png"), for: .normal)
        }
    }
    
}
