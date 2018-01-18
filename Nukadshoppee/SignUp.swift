//
//  SignUp.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 17/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class SignUp: UIViewController {

    
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addDoneButtonOnKeyboard()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        if(txtMobileNumber.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Mobile Number")
        }
        else if(txtPassword.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Password")
        }
        else if(txtConfirmPassword.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Confirm Password")
        }
        else
        {
            if !isValidPhoneNumber(value: txtMobileNumber.text!)
            {
                self.showAlert(title: "Alert", message: "Please Enter Valid Mobile Number")
            }
            else
            {
                let password = txtPassword.text
                let confirmpassword = txtConfirmPassword.text
                
                if (confirmpassword != password)
                {
                   self.showAlert(title: "Alert", message: "Confirm Password doesnot match Password")
                }
                else
                {
                    UserSignUp()
                }
                
            }
        }
    }
    
    func UserSignUp()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let otpView = storyboard.instantiateViewController(withIdentifier: "otpView") as! OtpView
        self.present(otpView, animated: true, completion: nil)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func addDoneButtonOnKeyboard()
    {
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(cancelKeyboard))
        
        var items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as! [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        txtPassword.inputAccessoryView = doneToolbar
        txtMobileNumber.inputAccessoryView = doneToolbar
        txtConfirmPassword.inputAccessoryView = doneToolbar
    }
    @objc func cancelKeyboard(){
        self.view.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
