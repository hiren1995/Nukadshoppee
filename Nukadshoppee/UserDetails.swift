//
//  UserDetails.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 17/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

var Gender:String = "Male"
var GenderId:Int = 1


class UserDetails: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{

    @IBOutlet weak var imgMale: UIImageView!
    @IBOutlet weak var imgFemale: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtWhatsAppNumber: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtReligion: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtPincode: UITextField!
    @IBOutlet weak var lblReference: UILabel!
    @IBOutlet weak var txtReferenceCode: UITextField!
    @IBOutlet weak var imgReference: UIImageView!
    @IBOutlet weak var btnClickhere: UIButton!
    @IBOutlet weak var txtOtherReligion: UITextField!
    
    @IBOutlet weak var VerifyDialouge: UIView!
    @IBOutlet weak var viewAlpha: UIView!
    
    
    var ReligionDict = JSON()
    var StateDict = JSON()
    var CityDict = JSON()
    
    var DateString = String()
    
    var DataPickerView = UIPickerView()
    var activeTextView: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomView.addShadow(location: .top, color: UIColor.black, opacity: 0.3, radius: 5.0)
        
        imgFemale.image = nil
        imgFemale.backgroundColor = UIColor.white
        imgFemale.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
        
        txtOtherReligion.isHidden = true
        viewAlpha.isHidden = true
        VerifyDialouge.isHidden = true
        
        txtReferenceCode.isHidden = true
        imgReference.isHidden = true
        
        DataPickerView.delegate = self
        DataPickerView.dataSource = self
        
        txtNumber.text = udefault.value(forKey: MobileNumber) as? String
        
        //txtName,txtEmail,txtWhatsAppNumber,txtDOB,txtReligion,txtAddress,txtArea,txtState,txtCity,txtPincode
        
        txtName.delegate = self
        txtName.tag = 0
        txtName.returnKeyType = .next
        txtEmail.delegate = self
        txtEmail.tag = 1
        txtEmail.returnKeyType = .next
        txtWhatsAppNumber.delegate = self
        txtWhatsAppNumber.tag = 2
        txtWhatsAppNumber.returnKeyType = .next
        txtDOB.delegate = self
        txtDOB.tag = 3
        txtDOB.returnKeyType = .next
        txtReligion.delegate = self
        txtReligion.tag = 4
        txtReligion.returnKeyType = .next
        txtAddress.delegate = self
        txtAddress.tag = 5
        txtAddress.returnKeyType = .next
        txtArea.delegate = self
        txtArea.tag = 6
        txtArea.returnKeyType = .next
        txtState.delegate = self
        txtState.tag = 7
        txtState.returnKeyType = .next
        txtCity.delegate = self
        txtCity.tag = 8
        txtCity.returnKeyType = .next
        txtPincode.delegate = self
        txtPincode.tag = 0
        txtPincode.returnKeyType = .done
        
        
        loadData()
        
        addDoneButtonOnKeyboard()
        addDoneStatePicker()
        addDoneReligionPicker()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClickHere(_ sender: UIButton) {
        lblReference.text = "Reference Code"
        txtReferenceCode.isHidden = false
        imgReference.isHidden = false
        btnClickhere.isHidden = true
    }
    
    @IBAction func btnMaleClicked(_ sender: Any) {
        MaleRadioButton()
    }
    
    
    @IBAction func btnFemaleClicked(_ sender: Any) {
        FemaleRadioButton()
    }
    
    func MaleRadioButton()
    {
        imgMale.image = UIImage(named: "radio-on")
        imgMale.removeImageborder()
        Gender = "Male"
        GenderId = 1
        imgFemale.image = nil
        imgFemale.backgroundColor = UIColor.white
        imgFemale.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
    }
    func FemaleRadioButton()
    {
        imgFemale.image = UIImage(named: "radio-on")
        imgFemale.removeImageborder()
        Gender = "Female"
        GenderId = 2
        imgMale.image = nil
        imgMale.backgroundColor = UIColor.white
        imgMale.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
    }

    func loadData()
    {
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let ReligionParameters:Parameters = [:]
        
        
        Alamofire.request(ReligionListAPI, method: .post, parameters: ReligionParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response)in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                print(JSON(response.result.value))
                
                self.ReligionDict = JSON(response.result.value!)
                
                if(self.ReligionDict["status"] == "success")
                {
                   
                    
                }
                else if(self.ReligionDict["status"] == "failure")
                {
                    self.showAlert(title: "Alert", message: "Something went wrong while getting Religion List")
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
        
        let StateParameters:Parameters = [:]
        
        
        Alamofire.request(StateListAPI, method: .post, parameters: StateParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response)in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                print(JSON(response.result.value))
                
                self.StateDict = JSON(response.result.value!)
                
                if(self.StateDict["status"] == "success")
                {
                    
                   
                }
                else if(self.StateDict["status"] == "failure")
                {
                    self.showAlert(title: "Alert", message: "Something went wrong while getting State List")
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
        
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
       
        if(txtName.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Name")
        }
        else if(txtEmail.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Email")
        }
        else if(txtNumber.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Number")
        }
        else if(txtDOB.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Date of Birth")
        }
        else if(txtReligion.text == "")
        {
             self.showAlert(title: "Alert", message: "Please Enter Religion")
        }
        else if(txtAddress.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Address")
        }
        else if(txtArea.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Area")
        }
        else if(txtState.text == "")
        {
             self.showAlert(title: "Alert", message: "Please Enter State")
        }
        else if(txtCity.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter City")
        }
        else if(txtPincode.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Pincode")
        }
        
        else
        {
            if !isValidEmail(testStr: txtEmail.text!)
            {
                self.showAlert(title: "Alert", message: "Please Enter Valid Email Address")
            }
            else
            {
            
                
                if(txtWhatsAppNumber.text == "")
                {
                    txtWhatsAppNumber.text = udefault.value(forKey: MobileNumber) as? String
                }
                
                SubmitData()
                
            }
        }
        
    }
    
    func SubmitData()
    {
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        print(DateString)
        
        let UserDetailsParameters:Parameters = ["app_user_name": txtName.text! , "app_user_dob" : DateString,"app_user_email" : txtEmail.text!,"app_user_contact_number" : udefault.value(forKey: MobileNumber) as! String,"app_user_whatsapp_number" : txtWhatsAppNumber.text!,"app_user_gender":GenderId,"app_user_religion":udefault.value(forKey: ReligionID) as! Int,"app_user_address":txtAddress.text!,"app_user_area":txtArea.text!,"app_user_city":udefault.value(forKey: CityId) as! Int,"app_user_pincode":txtPincode.text!,"app_user_state":udefault.value(forKey: StateId) as! Int,"app_user_device_id" : udefault.value(forKey:DeviceId) as! String,"app_user_device_token":udefault.value(forKey: DeviceToken) as! String,"app_user_device_type":2,"refferal_code":txtReferenceCode.text!,"app_user_id" : udefault.value(forKey:UserId) as! Int]
        
        print(UserDetailsParameters)
        
        Alamofire.request(UserDetailsAPI, method: .post, parameters: UserDetailsParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                let tempDict = JSON(response.result.value!)
                
                //print(tempDict["data"]["user_id"])
                
                if(tempDict["status"] == "success")
                {
                    if(tempDict["status_code"].intValue == 1)
                    {
                        //udefault.set(tempDict["inserted_user"], forKey: UserData)
                        
                        self.viewAlpha.isHidden = false
                        self.VerifyDialouge.isHidden = false
                    }
                    else
                    {
                        self.showAlert(title: "Verified Already", message: "This email id is verified already please change your email id")
                    }
                }
                else if(tempDict["status"] == "failure")
                {
                    self.showAlert(title: "Alert", message: "Something went wrong while entering your Data")
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
        
        //viewAlpha.isHidden = false
        //VerifyDialouge.isHidden = false
    }
    
    @IBAction func btnOK(_ sender: UIButton) {
        
        udefault.set(true, forKey: isDetails)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signIn = storyboard.instantiateViewController(withIdentifier: "signIn") as! SignIn
        self.present(signIn, animated: true, completion: nil)
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        
        viewAlpha.isHidden = true
        VerifyDialouge.isHidden = true
    }
    
    @IBAction func txtDOBTapped(_ sender: UITextField) {
        var datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePickertxtFrom), for: UIControlEvents.valueChanged)
    }
    
    @objc func handleDatePickertxtFrom(sender: UIDatePicker) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        txtDOB.text = dateFormatter.string(from: sender.date)
        
        var dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        DateString = dateFormatter2.string(from: sender.date)
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
        
        txtDOB.inputAccessoryView = doneToolbar
        txtName.inputAccessoryView = doneToolbar
        txtEmail.inputAccessoryView = doneToolbar
        //txtReligion.inputAccessoryView = doneToolbar
        txtAddress.inputAccessoryView = doneToolbar
        txtArea.inputAccessoryView = doneToolbar
        txtPincode.inputAccessoryView = doneToolbar
        txtReferenceCode.inputAccessoryView = doneToolbar
        txtOtherReligion.inputAccessoryView = doneToolbar
        //txtState.inputAccessoryView = doneToolbar
        txtCity.inputAccessoryView = doneToolbar
        
    }
    @objc func cancelKeyboard(){
        self.view.endEditing(true)
        
    }
    
    func addDoneStatePicker()
    {
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(cancelPicker))
        
        var items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as! [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        txtState.inputAccessoryView = doneToolbar
    }
    @objc func cancelPicker(){
        
        self.view.endEditing(true)
        
        let CityParameters:Parameters = ["state_id": udefault.value(forKey: StateId)]
        
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        Alamofire.request(CityListAPI, method: .post, parameters: CityParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response)in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                self.CityDict = JSON(response.result.value!)
                
                if(self.CityDict["status"] == "success")
                {
                    
                }
                else if(self.CityDict["status"] == "failure")
                {
                    self.showAlert(title: "Alert", message: "Something went wrong while getting city List")
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
        
        
    }
    
    func addDoneReligionPicker()
    {
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(cancelKeyboardReligion))
        
        var items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as! [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        txtReligion.inputAccessoryView = doneToolbar
    }
    @objc func cancelKeyboardReligion(){
        
        self.view.endEditing(true)
        
        if(udefault.value(forKey: ReligionID) as! Int == 0)
        {
            txtOtherReligion.isHidden = false
        }
        else
        {
            txtOtherReligion.isHidden = true
        }
        
    }
    
    @IBAction func otherReligionEntered(_ sender: UITextField) {
        
        if(txtOtherReligion.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Other Religion Name")
        }
        else
        {
            let addReligionParameters:Parameters = ["religion_name": txtOtherReligion.text!]
            
            let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
            
            Alamofire.request(AddReligionAPI, method: .post, parameters: addReligionParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response)in
                if(response.result.value != nil)
                {
                    Spinner.hide(animated: true)
                    
                    print(JSON(response.result.value))
                    
                    let addedreligionDict = JSON(response.result.value!)
                    
                    if(addedreligionDict["status"] == "success")
                    {
                        self.txtOtherReligion.text = addedreligionDict["add_religion"][0]["religion_name"].stringValue
                        udefault.set(addedreligionDict["add_religion"][0]["religion_id"].intValue, forKey: ReligionID)
                        udefault.set(addedreligionDict["add_religion"][0]["religion_name"].stringValue, forKey: ReligionName)
                    }
                    else if(addedreligionDict["status"] == "failure")
                    {
                        self.showAlert(title: "Alert", message: "Something went wrong while adding religion ")
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
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(activeTextView == txtReligion)
        {
            return ReligionDict["bank_list"].count
        }
        if(activeTextView == txtCity)
        {
            return CityDict["city_list"].count
        }
        return StateDict["state_list"].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(activeTextView == txtReligion)
        {
            return ReligionDict["bank_list"][row]["religion_name"].stringValue
        }
        if(activeTextView == txtCity)
        {
            return CityDict["city_list"][row]["name"].stringValue
        }
        return StateDict["state_list"][row]["name"].stringValue
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(activeTextView == txtReligion)
        {
              txtReligion.text = ReligionDict["bank_list"][row]["religion_name"].stringValue
              udefault.set(ReligionDict["bank_list"][row]["religion_name"].stringValue, forKey: ReligionName)
              udefault.set(ReligionDict["bank_list"][row]["religion_id"].intValue, forKey: ReligionID)
        }
        else if(activeTextView == txtCity)
        {
            txtCity.text = CityDict["city_list"][row]["name"].stringValue
            udefault.set(CityDict["city_list"][row]["name"].stringValue, forKey: CityName)
            udefault.set(CityDict["city_list"][row]["id"].intValue, forKey: CityId)
        }
        else
        {
            txtState.text = StateDict["state_list"][row]["name"].stringValue
            udefault.set(StateDict["state_list"][row]["id"].intValue, forKey: StateId)
            udefault.set(StateDict["state_list"][row]["name"].stringValue, forKey: StateName)
        }
      
    }
    
    @IBAction func ReligionTapped(_ sender: UITextField) {
        
        activeTextView = sender
        txtReligion.inputView = DataPickerView
        
    }
    @IBAction func txtStateTapped(_ sender: UITextField) {
        
        activeTextView = sender
        txtState.inputView = DataPickerView
        
    }
    
    @IBAction func txtCityTapped(_ sender: UITextField) {
        
        activeTextView = sender
        txtCity.inputView = DataPickerView
       
    }
    @IBAction func txtPincodeTapped(_ sender: UITextField) {
        self.view.frame.origin.y -= 270
    }
    
    @IBAction func txtPincodeEdited(_ sender: UITextField) {
        self.view.frame.origin.y += 270
    }
    @IBAction func txtRefereceTapped(_ sender: UITextField) {
        self.view.frame.origin.y -= 270
    }
    
    @IBAction func txtReferenceEdited(_ sender: UITextField) {
        self.view.frame.origin.y += 270
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
