//
//  SignIn.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 16/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

var UserData = JSON()
var TaxData = JSON()

class SignIn: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addDoneButtonOnKeyboard()
        
        txtMobileNumber.delegate = self
        txtMobileNumber.tag = 0
        txtMobileNumber.returnKeyType = .next
        txtPassword.delegate = self
        txtPassword.tag = 1
        txtPassword.returnKeyType = .done
        
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func btnSignIn(_ sender: Any) {
        
        if(txtMobileNumber.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Mobile Number")
        }
        else if(txtPassword.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Password")
            
        }
        else
        {
            if !isValidPhoneNumber(value: txtMobileNumber.text!)
            {
                    self.showAlert(title: "Alert", message: "Please Enter Valid Mobile Number")
            }
            else
            {
                Authenticate()
            }
           
        }
        
    }
    
    @IBAction func btnForgetPassword(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let forgetPassword = storyboard.instantiateViewController(withIdentifier: "forgetPassword") as! ForgetPassword
        self.present(forgetPassword, animated: true, completion: nil)
    }
    
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUp = storyboard.instantiateViewController(withIdentifier: "signUp") as! SignUp
        self.present(signUp, animated: true, completion: nil)
        
    }
    
    func Authenticate()
    {
       
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        //let loginParameters:Parameters = ["app_user_contact_number": txtMobileNumber.text! , "app_user_password" : txtPassword.text! ,"app_user_device_id" : "1d6fe4ae37368917" , "app_user_device_token" : "feqCqFAZfpY:APA91bFUvYa2xD0dNgw-5OrdW4UoJw0i0nOdO6HSPJEwNDUeJ8jUdDF8_V1oHyiviT_HU3gec_StQvdUOBKSD_PVY0RdZYJHrzjx-EXCr5-kfKVNoesTarnB1hts06brsPFQBiPBasve"]
        
        let loginParameters:Parameters = ["app_user_contact_number": txtMobileNumber.text! , "app_user_password" : txtPassword.text! ,"app_user_device_id" : udefault.value(forKey: DeviceId) , "app_user_device_token" : udefault.value(forKey:  DeviceToken)]
        
        
        Alamofire.request(LoginAPI, method: .post, parameters: loginParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                
                print(JSON(response.result.value))
                
                let tempDict = JSON(response.result.value!)
                
                if(tempDict["status_code"].intValue == 1)
                {
                    
                    Spinner.hide(animated: true)
                    
                    udefault.set(true, forKey: isLogin)
                    udefault.set(self.txtMobileNumber.text!, forKey: LoginMobile)
                    udefault.set(self.txtPassword.text!, forKey: LoginPassword)
                
                    UserData = tempDict["user_info"][0]
                    TaxData = tempDict["tax_info"][0]
                    udefault.set(UserData["app_user_token"].stringValue, forKey: UserToken)
                    udefault.set(UserData["app_user_id"].intValue, forKey: UserId)
                    
                    //print(UserData)
                    //print(TaxData)
                    
                    /*
                     
                    var userData = NSDictionary() //put this above class as global variable
                     
                    Derive data from userData NSDictionary in this way to set in update profile page..
                    
                    userData = response.result.value as! NSDictionary
                    print(userData)
                    print(JSON(userData["tax_info"]))
                    print(JSON(userData["user_info"]))
                    let x = JSON(userData["tax_info"])
                    print(x[0]["terms_condition"])
                    let y = JSON(userData["user_info"])
                    print(y[0]["app_user_address"])
                    */
                    
                    let dashboard = storyboard.instantiateViewController(withIdentifier: "dashboard") as! Dashboard
                    self.present(dashboard, animated: true, completion: nil)
                }
                else if(tempDict["status_code"].intValue == 2)
                {
                    Spinner.hide(animated: true)
                    udefault.set(tempDict["user_info"].intValue, forKey: UserId)
                    let userDetails = storyboard.instantiateViewController(withIdentifier: "userDetails") as! UserDetails
                    self.present(userDetails, animated: true, completion: nil)
                }
                else if(tempDict["status_code"].intValue == 4)
                {
                    
                    let VerifyAlert = UIAlertController(title: "Verify Mobile Number", message: "OTP has been sent to you Please Verify Mobile Number", preferredStyle: UIAlertControllerStyle.alert)
                    
                    VerifyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        let SendOTPParameters:Parameters = ["verification_contact_number": self.txtMobileNumber.text! , "verification_password" : self.txtPassword.text! ]
                        
                        Alamofire.request(SendOTPAPI, method: .post, parameters: SendOTPParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                            if(response.result.value != nil)
                            {
                                Spinner.hide(animated: true)
                                
                                print(JSON(response.result.value))
                                
                                let tempDictOTP = JSON(response.result.value!)
                                
                                if(tempDictOTP["success"] == "success")
                                {
                                    
                                    udefault.set(self.txtMobileNumber.text, forKey: MobileNumber)
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let otpView = storyboard.instantiateViewController(withIdentifier: "otpView") as! OtpView
                                    self.present(otpView, animated: true, completion: nil)
                                }
                                else if(tempDictOTP["status"] == "failure")
                                {
                                    
                                    self.showAlert(title: "Alert", message: "Something went wrong while sending OTP")
                                }
                                
                            }
                            else
                            {
                                
                                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                            }
                        })
                        
                        
                    }))
                    
                    VerifyAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                        
                        print("Cancelled")
                        
                    }))
                   
                    self.present(VerifyAlert, animated: true, completion: nil)
                    
                }
                else if(tempDict["status_code"].intValue == 3)
                {
                    Spinner.hide(animated: true)
                    self.showAlert(title: "Verify Email", message: "You are registered User but Your Email is not Verified Please Verify that first")
                }
                else
                {
                    Spinner.hide(animated: true)
                    self.showAlert(title: "InVaild User", message: "Invalid Login Details")
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
 
 
        /*
          //let Details = UserDefaults.standard.bool(forKey: isDetails)
        if Details
        {
            let dashboard = storyboard.instantiateViewController(withIdentifier: "dashboard") as! Dashboard
            self.present(dashboard, animated: true, completion: nil)
        }
        else
        {
            let userDetails = storyboard.instantiateViewController(withIdentifier: "userDetails") as! UserDetails
            self.present(userDetails, animated: true, completion: nil)
        }
         */
 
        
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
        
    }
    @objc func cancelKeyboard(){
        self.view.endEditing(true)
        
    }
    
    @IBAction func PasswordBeginEditing(_ sender: UITextField) {
        self.view.frame.origin.y -= 100
    }
    
    @IBAction func PasswordDidEnd(_ sender: UITextField) {
        self.view.frame.origin.y += 100
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
