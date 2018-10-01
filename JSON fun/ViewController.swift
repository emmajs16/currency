//
//  ViewController.swift
//  JSON fun
//
//  Created by Emma Stoverink on 10/1/18.
//  Copyright © 2018 Emma Stoverink. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    var activeCurrency:Double = 0
    
//    KEYBOARD
    //Dismiss keyboard method
    func keyboardDismiss() {
        input.resignFirstResponder()
    }
    
    //ADD Gesture Recignizer to Dismiss keyboard then view tapped
    @IBAction func viewTapped(_ sender: AnyObject) {
        keyboardDismiss()
    }
    
    //Dismiss keyboard using Return Key (Done) Button
    //Do not forgot to add protocol UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyboardDismiss()
        
        return true
    }
    
//    OBJECTS
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var output: UILabel!
    
//    CREATING PICKER VIEW
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myCurrency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myCurrency[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = myValues[row]
    }
    
//  BUTTON FUNCTION
    @IBAction func action(_ sender: Any) {
        if (input.text != ""){
        output.text = String(Double(input.text!)! * activeCurrency)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        GETTING DATA
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=2c77d5dfcc4f9c6b85aa0e78891fe1ab")
        let task = URLSession.shared.dataTask(with: url!) { (data, response , error) in
            if error != nil{
                print("ERROR!!")
            }
            else{
                if let content = data {
                    do{
                        let myJson =  try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
//                        print(myJson)
                        if let rates = myJson["rates"] as? NSDictionary{
//                            print(rates)
                            for (key, value) in rates{
                                self.myCurrency.append((key as? String)!)
                                self.myValues.append((value as? Double)!)
                            }
                            print(self.myCurrency)
                            print(self.myValues)
                        }
                    }
                    catch{
                        
                    }
                }
            }
            self.pickerView.reloadAllComponents() 
        }
        task.resume()
    }


}

