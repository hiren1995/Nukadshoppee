//
//  ForgetPassword.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 18/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class ForgetPassword: UIViewController {

    @IBOutlet weak var txtEmailorNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButtonOnKeyboard()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnNext(_ sender: UIButton) {
        if(txtEmailorNumber.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Email or Mobile Number")
        }
        else
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let forgetPasswordOTP = storyboard.instantiateViewController(withIdentifier: "forgetPasswordOTP") as! ForgetPasswordOTP
            self.present(forgetPasswordOTP, animated: true, completion: nil)
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
        
        txtEmailorNumber.inputAccessoryView = doneToolbar
        
        
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
