//
//  BankDetails.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 27/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

var AccountType:String = "Saving"
var AccountTypeID:Int = 1

class BankDetails: UIViewController {

    @IBOutlet weak var imgSaving: UIImageView!
    @IBOutlet weak var imgCurrent: UIImageView!
    @IBOutlet weak var txtBankName: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var txtIFSC: UITextField!
    
    var EditBankDetailsFlag:Int = 0
    var bankDetails = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        imgCurrent.image = nil
        imgCurrent.backgroundColor = UIColor.white
        imgCurrent.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
        
        addDoneButtonOnKeyboard()
        
        if(EditBankDetailsFlag == 1)
        {
            loadBankDetails()
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSavingClicked(_ sender: Any) {
        SavingRadioButton()
    }
    
    
    @IBAction func btnCurrentClicked(_ sender: Any) {
        CurrentRadioButton()
    }
    
    func SavingRadioButton()
    {
        imgSaving.image = UIImage(named: "radio-on")
        imgSaving.removeImageborder()
        AccountType = "Saving"
        AccountTypeID = 1
        imgCurrent.image = nil
        imgCurrent.backgroundColor = UIColor.white
        imgCurrent.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
    }
    func CurrentRadioButton()
    {
        imgCurrent.image = UIImage(named: "radio-on")
        imgCurrent.removeImageborder()
        AccountType = "Current"
        AccountTypeID = 2
        imgSaving.image = nil
        imgSaving.backgroundColor = UIColor.white
        imgSaving.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
    }

    @IBAction func btnSubmit(_ sender: UIButton) {
        
        if(txtName.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Account Holder Name")
        }
        else if(txtBankName.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Bank Name")
        }
        else if(txtAccountNumber.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Account Number")
        }
        else if(txtIFSC.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter IFSC Code")
        }
        else
        {
            if(EditBankDetailsFlag == 1)
            {
                let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
                let EditBankParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String,"bank_app_user_name":txtName.text!,"bank_name":txtBankName.text!,"bank_acc_no":txtAccountNumber.text!,"bank_ifsc_code":txtIFSC.text!,"bank_acc_type":AccountTypeID,"bank_id": bankDetails["bank_id"].intValue]
                
                Alamofire.request(EditBankAPI, method: .post, parameters: EditBankParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                    if(response.result.value != nil)
                    {
                        Spinner.hide(animated: true)
                        
                        print(JSON(response.result.value))
                        
                        let tempDict = JSON(response.result.value)
                        
                        if(tempDict["status"] == "success")
                        {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let banksList = storyboard.instantiateViewController(withIdentifier: "banksList") as! BanksList
                            self.present(banksList, animated: true, completion: nil)
                            
                        }
                        
                    }
                    else
                    {
                        Spinner.hide(animated: true)
                        self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                    }
                })
            }
            else
            {
                let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
                let AddBankParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String,"bank_app_user_name":txtName.text!,"bank_name":txtBankName.text!,"bank_acc_no":txtAccountNumber.text!,"bank_ifsc_code":txtIFSC.text!,"bank_acc_type":AccountTypeID]
                
                Alamofire.request(AddBankAPI, method: .post, parameters: AddBankParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                    if(response.result.value != nil)
                    {
                        Spinner.hide(animated: true)
                        
                        print(JSON(response.result.value))
                        
                        let tempDict = JSON(response.result.value)
                        
                        if(tempDict["status"] == "success")
                        {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let banksList = storyboard.instantiateViewController(withIdentifier: "banksList") as! BanksList
                            self.present(banksList, animated: true, completion: nil)
                            
                        }
                        
                    }
                    else
                    {
                        Spinner.hide(animated: true)
                        self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                    }
                })
            }
            
        }
        
    }
    
    func loadBankDetails()
    {
        txtName.text = bankDetails["bank_app_user_name"].stringValue
        txtBankName.text = bankDetails["bank_name"].stringValue
        txtAccountNumber.text = bankDetails["bank_acc_no"].stringValue
        txtIFSC.text = bankDetails["bank_ifsc_code"].stringValue
        if(bankDetails["bank_acc_type"].intValue == 1)
        {
            SavingRadioButton()
        }
        else
        {
            CurrentRadioButton()
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
        
        txtName.inputAccessoryView = doneToolbar
        txtBankName.inputAccessoryView = doneToolbar
        txtAccountNumber.inputAccessoryView = doneToolbar
        txtIFSC.inputAccessoryView = doneToolbar
    }
    @objc func cancelKeyboard(){
        self.view.endEditing(true)
        
    }
    @IBAction func IFSCTapped(_ sender: UITextField) {
        self.view.frame.origin.y -= 100
    }
    @IBAction func IFSCendEditing(_ sender: UITextField) {
        self.view.frame.origin.y += 100
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
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
