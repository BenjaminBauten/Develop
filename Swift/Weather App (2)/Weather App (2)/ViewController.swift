//
//  ViewController.swift
//  Weather App (2)
//
//  Created by Benjamin Bauten on 13/03/2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var CompareResultText: UITextView!
    
    @IBAction func CompareNowButton(_ sender: Any) {
        
        AF.request("https://api.openweathermap.org/data/2.5/weather?q=Kevelaer&appid=1319104a3baa155478e1466e9bc73c7d&units=metric").responseJSON {
            response in
            
            let json = JSON(response.value)
            print(json)
            let y = json["base"].string
            let z = json["name"].string
            let a = json["main"]["humidity"].float
            let t = json["main"]["temp"].float
            print(t)
            self.CompareResultText.text = (y as! String) + " in " + (z as! String) + " shows a humidity of " + (NSString(format: "%.2f", a as! Float) as String) + " and temperature of " + (NSString(format: "%.2f", t as! Float) as String) as! String
            
        }
    }

}

