//  ViewController.swift
//  Caesar Verschluesselung
//
//  Created by Benjamin Bauten on 18/02/2021.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var normalText: UITextView!
    @IBOutlet weak var encryptedText: UITextView!
    @IBOutlet weak var encodeButton: UIButton!
    @IBOutlet weak var decodeButton: UIButton!
    @IBOutlet weak var positionTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        encodeButton.layer.cornerRadius = 10
        decodeButton.layer.cornerRadius = 10
        normalText.layer.cornerRadius = 15
        encryptedText.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }

    func moveText(arg inputText: String, arg positionInt: Int) -> String{
        var outputText = ""
        for inputUnicodeScalar in inputText.unicodeScalars {
            let inputLetter = Int(inputUnicodeScalar.value)
            let lowercaseA = Int(("a" as UnicodeScalar).value)
            let lowercaseZ = Int(("z" as UnicodeScalar).value)
            let capitalA = Int(("A" as UnicodeScalar).value)
            let capitalZ = Int(("Z" as UnicodeScalar).value)
            if ((capitalA <= inputLetter) && (inputLetter <= capitalZ)){
                let outputLetter = ((inputLetter - capitalA + 26 + positionInt) % 26) + capitalA;
                outputText += String(UnicodeScalar(outputLetter)!)
            } else if ((lowercaseA <= inputLetter) && (inputLetter <= lowercaseZ)){
                let outputLetter = ((inputLetter - lowercaseA + 26 + positionInt) % 26) + lowercaseA
                outputText += String(UnicodeScalar(outputLetter)!)
            } else{
                outputText += String(UnicodeScalar(inputLetter)!)
            }
        }
        return outputText
    }

    @IBAction func encodeText(_ sender: Any) {
        if let positionString = positionTextField.text,
           let positionInt = Int(positionString){
            encryptedText.text = moveText(arg: normalText.text, arg: positionInt)
            }
    }

    @IBAction func decodeText(_ sender: Any) {
        if let positionString = positionTextField.text,
           let positionInt = Int(positionString){
            normalText.text = moveText(arg: encryptedText.text, arg: -positionInt)
        }
    }

}
