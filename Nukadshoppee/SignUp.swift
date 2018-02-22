//
//  SignUp.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 17/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class SignUp: UIViewController,UITextFieldDelegate  {

    
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addDoneButtonOnKeyboard()
        
        txtPassword.delegate = self
        txtPassword.tag = 0
        txtPassword.returnKeyType = .next
        txtConfirmPassword.delegate = self
        txtConfirmPassword.tag = 1
        txtConfirmPassword.returnKeyType = .done
        
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
        
        let SendOTPParameters:Parameters = ["verification_contact_number": txtMobileNumber.text! , "verification_password" : txtPassword.text! ]
        
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Alamofire.request(SendOTPAPI, method: .post, parameters: SendOTPParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                let tempDict = JSON(response.result.value!)
                
                if(tempDict["status"] == "success")
                {
                    udefault.set(self.txtMobileNumber.text, forKey: MobileNumber)
                    udefault.set(self.txtPassword.text, forKey: SignUpPassword)
                    
                    if(tempDict["staus_code"].intValue == 1)
                    {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let otpView = storyboard.instantiateViewController(withIdentifier: "otpView") as! OtpView
                        self.present(otpView, animated: true, completion: nil)
                    }
                    else if(tempDict["staus_code"].intValue == 2)
                    {
                       
                        let VerifiedAlert = UIAlertController(title: "Account Already Verified", message: "Your account is already verified with otp please fill the form for activate you account and mobile number must be same.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        VerifiedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let userDetails = storyboard.instantiateViewController(withIdentifier: "userDetails") as! UserDetails
                            self.present(userDetails, animated: true, completion: nil)
                            
                        }))
                        
                        VerifiedAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                            
                            print("Cancelled")
                            
                        }))
                        
                        self.present(VerifiedAlert, animated: true, completion: nil)
         
                        
                    }
                    else
                    {
                        let OTPAlert = UIAlertController(title: "Account Already Registered", message: "Your account is already Registered. Please Verify Your Account Using the OTP sent to your Mobile Number", preferredStyle: UIAlertControllerStyle.alert)
                        
                        OTPAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let otpView = storyboard.instantiateViewController(withIdentifier: "otpView") as! OtpView
                            self.present(otpView, animated: true, completion: nil)
                            
                        }))
                        
                        OTPAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                            
                            print("Cancelled")
                            
                        }))
                        
                        self.present(OTPAlert, animated: true, completion: nil)
                        
                        
                    }
                    
                }
                else if(tempDict["status"] == "failure")
                {
                    self.showAlert(title: "Alert", message: "Something went wrong while Signup.")
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
 
        
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let otpView = storyboard.instantiateViewController(withIdentifier: "otpView") as! OtpView
        //self.present(otpView, animated: true, completion: nil)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
        
    {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            
            nextField.becomeFirstResponder()
            
        } else {
            
            textField.resignFirstResponder()
            
            return true;
            
        }
        
        return false
        
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
