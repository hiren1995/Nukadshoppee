//
//  SignIn.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 16/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class SignIn: UIViewController {

    
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addDoneButtonOnKeyboard()
        
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
        let Details = UserDefaults.standard.bool(forKey: isDetails)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if Details
        {
            let viewController = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
            self.present(viewController, animated: true, completion: nil)
        }
        else
        {
            let userDetails = storyboard.instantiateViewController(withIdentifier: "userDetails") as! UserDetails
            self.present(userDetails, animated: true, completion: nil)
        }
        
        
    }
    
    //---------------------------------- Code for adjusting view depending upon the keyboard open and close...------------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        self.view.frame.origin.y -= 270
        
        /*
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
         
            self.view.frame.origin.y -= keyboardSize.height
            print(keyboardSize.height)
        }
        */
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.view.frame.origin.y += 270
        
        /*
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
         
            self.view.frame.origin.y += keyboardSize.height
         
        }
        */
        
    }
    
    //-------------------------------------------------------- End -----------------------------------------------------------------------------------------
    
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
