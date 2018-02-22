//
//  OtpView.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 17/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class OtpView: UIViewController{

    @IBOutlet weak var txtOTP: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addDoneButtonOnKeyboard()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnNext(_ sender: Any) {
        if(txtOTP.text == "")
        {
           self.showAlert(title: "Alert", message: "Please Enter OTP")
        }
        else
        {
            let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
            
            let VerifyOTPParameters:Parameters = ["verification_contact_number": udefault.value(forKey: MobileNumber) as! String, "verification_code" : txtOTP.text! ]
            
            print(VerifyOTPParameters)
            
            Alamofire.request(VerifyOTPAPI, method: .post, parameters: VerifyOTPParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                if(response.result.value != nil)
                {
                    Spinner.hide(animated: true)
                    
                    print(JSON(response.result.value))
                    
                    let tempDict = JSON(response.result.value!)
                    
                    if(tempDict["status"] == "success")
                    {
                        udefault.set(tempDict["user_id"].intValue, forKey: UserId)
             
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let userDetails = storyboard.instantiateViewController(withIdentifier: "userDetails") as! UserDetails
                        self.present(userDetails, animated: true, completion: nil)
                    }
                    else if(tempDict["status"] == "failure")
                    {
                        self.showAlert(title: "Alert", message: "OTP not Verified")
                    }
                    
                }
                else
                {
                    Spinner.hide(animated: true)
                    self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                }
            })
 
            
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let userDetails = storyboard.instantiateViewController(withIdentifier: "userDetails") as! UserDetails
            //self.present(userDetails, animated: true, completion: nil)
            
        }
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
        
        txtOTP.inputAccessoryView = doneToolbar
       
        
    }
    @objc func cancelKeyboard(){
        self.view.endEditing(true)
        
    }
    
    @IBAction func resendOTP(_ sender: UIButton) {
        
        let SendOTPParameters:Parameters = ["verification_contact_number": udefault.value(forKey: MobileNumber ) as! String , "verification_password" : udefault.value(forKey: SignUpPassword) as! String ]
        
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Alamofire.request(SendOTPAPI, method: .post, parameters: SendOTPParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                let tempDict = JSON(response.result.value!)
                
                if(tempDict["status"] == "success")
                {
                    
                    if(tempDict["staus_code"].intValue == 1)
                    {
                        self.showAlert(title: "OTP Sent", message: "OTP has been sent Successfully")
                    }
                    
                }
                else if(tempDict["status"] == "failure")
                {
                    self.showAlert(title: "Alert", message: "Something went wrong while sending OTP")
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
        
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
