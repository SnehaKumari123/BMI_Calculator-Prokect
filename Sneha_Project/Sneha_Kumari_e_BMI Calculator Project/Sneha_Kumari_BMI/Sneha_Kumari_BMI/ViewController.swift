//
//  ViewController.swift
//  Sneha_Kumari_BMI
//
//  Created by Sneha on 4/15/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController,UITextFieldDelegate {
    var finalResult = Bmi(value: 0.0, message: "", links: [])
    var weight: Double = 0.0
    var height: Double = 0.0
    
    @IBOutlet var educatemeButton: UIButton!
    @IBOutlet var bmiMessage: UILabel!
    @IBOutlet var bmiLabel: UILabel!
    @IBOutlet var heightText: UITextField!
    @IBOutlet var weightText: UITextField!
    
    
    override func viewDidLoad() {
        educatemeButton.isEnabled = false
        super.viewDidLoad()
        heightText.delegate = self
        weightText.delegate = self
       
        
        
    }
    
    
    private func calculateBMI() {
        
        let params: [String: Any] = ["height": self.height, "weight": self.weight]
        let data = "http://webstrar99.fulton.asu.edu/page3/Service1.svc/calculateBMI"
        Alamofire.request(data, method: .get, parameters: params).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                if let bmi = responseValue["bmi"] as! Double? {
                    self.finalResult.value = bmi
                    
                    if(self.finalResult.value < 18)
                    {
                        self.bmiMessage.textColor = UIColor.blue
                    }
                    else if(self.finalResult.value >= 18 && self.finalResult.value < 25)
                    {
                        self.bmiMessage.textColor = UIColor.green
                    }
                    else if(self.finalResult.value >= 25 && self.finalResult.value < 30)
                    {
                        self.bmiMessage.textColor = UIColor.purple
                    }
                    else
                    {
                      self.bmiMessage.textColor = UIColor.red
                    }
                    
                    self.bmiLabel.text = "\(self.finalResult.value)"
                }
                if let educateArray = responseValue["more"] as! [String]? {
                    for link in educateArray {
                        self.finalResult.links.append(link)
                    }
                    if let risk = responseValue["risk"] as! String? {
                        self.finalResult.message = risk
                         self.bmiMessage.textAlignment = .center
                        self.bmiMessage.text = "\(self.finalResult.message)"
                    }
                }
            }
        }
    }
    @IBAction func BMIbutton(_ sender: Any) {
        if(Double(heightText.text!) == nil && Double(weightText.text!) == nil )
        {
            self.bmiMessage.text = "Please enter height and weight"
            self.bmiLabel.text = ""
            educatemeButton.isEnabled = false
        }
        else if(Double(heightText.text!) == nil )
        {
            self.bmiMessage.text = "Please enter height"
            self.bmiLabel.text = ""
            educatemeButton.isEnabled = false
            
        }
        else if(Double(weightText.text!) == nil )
        {
            self.bmiMessage.text = "Please enter weight"
            self.bmiLabel.text = ""
            educatemeButton.isEnabled = false
        }
        else{
            educatemeButton.isEnabled = true
            if let height = Double(heightText.text!) {
                self.height = height
            }
            
            
            if let weight = Double(weightText.text!) {
                
                self.weight = weight
                
            }
            calculateBMI()
        }
        
    }
    
    @IBAction func educatemeButton(_ sender: Any) {
        let url  = self.finalResult.links.first ?? "https://www.google.com"
        
        let VC = WebViewVC(urlString: url)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}
