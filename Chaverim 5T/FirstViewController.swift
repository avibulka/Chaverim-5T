//
//  FirstViewController.swift
//  Chaverim 5T
//
//  Created by Avi Bulka on 5/30/18.
//  Copyright © 2018 Avi Bulka. All rights reserved.
//

import UIKit
import MessageUI


class FirstViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    var stringName: String = ""
    var stringPhone: String = ""
    var stringProblem: String = ""
    var stringLocationArea: String = ""
    var stringAddress: String = ""
    var stringCross1: String = ""
    var stringCross2: String = ""
    var stringColorMakeModel: String = ""
    var stringDetails: String = " "
    
    
    @IBOutlet weak var locationArea: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var problem: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var cross1: UITextField!
    @IBOutlet weak var cross2: UITextField!
    @IBOutlet weak var colorMakeModel: UITextField!
    @IBOutlet weak var details: UITextField!

    
    @IBAction func submit(_ sender: Any) {
    
    stringName = name.text!
        stringPhone = phone.text!
        stringProblem = problem.text!
        stringLocationArea = locationArea.text!
        stringAddress = address.text!
        stringCross1 = cross1.text!
        stringCross2 = cross2.text!
        stringColorMakeModel = colorMakeModel.text!
        stringDetails = details.text!
        
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else{
            showMailError()
        }
        
        name.text=""
        phone.text=""
        problem.text=""
        locationArea.text="Choose Town"
        address.text=""
        cross1.text=""
        cross2.text=""
        colorMakeModel.text=""
        details.text=""
        
    
    }
    
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["d21@chaverim5t.org" ])
        mailComposerVC.setSubject("Chaverim Calls")
        mailComposerVC.setMessageBody ("Name: "+stringName+"\n"+"Phone Number: "+stringPhone+"\n"+"Problem: "+stringProblem+"\n"+"Location Area: "+stringLocationArea+"\n"+"Address: "+stringAddress+"\n"+"Cross Streets: "+stringCross1+"/"+stringCross2+"\n"+"Color & Make/Model: "+stringColorMakeModel+"\n"+"Details: "+stringDetails, isHTML: false)
        
        return mailComposerVC
    }
    
    func showMailError(){
        let sendMailErroralert = UIAlertController (title: "Could Not Send Email", message: "Your Device Could Not Send Email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErroralert.addAction(dismiss)
        self.present( sendMailErroralert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            // do whatever you need to do after dismissing the mail window
            switch result {
            case.cancelled: print("Cancelled")
            case.saved: print("Saved")
            case.sent:
                let alert = UIAlertController(title: "Thank You!", message: "Your message has been received, and someone will hopefully reach out within the next 20 minutes\n\n This app is sponsored by:\n Cross River Bank\n http://click2go.me/crossriverbank", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true)
            case.failed: print("Failed")
            }
        }
    }
    
    let locations = ["Choose Town","Atlantic Beach", "Bayswater", "Belle Harbor", "Belt Parkway", "Cedarhurst", "Far Rockaway", "Great Neck", "Hewlett", "Inwood", "JFK", "Lawrence", "Long Beach", "Lynbrook", "North Woodmere", "Oceanside", "Queens", "Valley Stream", "Van Wyck","West Hempstead", "Woodmere"]
    
    
    var selectedLocation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAreaPicker()
        createToolbar()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func createAreaPicker() {
        let areaPicker = UIPickerView()
        areaPicker.delegate = self
        
        locationArea.inputView = areaPicker
    }
    
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Hide Keybaord", style: .plain, target: self, action: #selector(FirstViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        locationArea.inputAccessoryView = toolBar
        colorMakeModel.inputAccessoryView = toolBar
        name.inputAccessoryView = toolBar
        phone.inputAccessoryView = toolBar
        problem.inputAccessoryView = toolBar
        address.inputAccessoryView = toolBar
        cross1.inputAccessoryView = toolBar
        cross2.inputAccessoryView = toolBar
        details.inputAccessoryView = toolBar
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension FirstViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedLocation = locations[row]
        locationArea.text = selectedLocation
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

