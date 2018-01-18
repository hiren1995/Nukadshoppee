//
//  UserDetails.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 17/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

var Gender:String = "Male"

class UserDetails: UIViewController {

    @IBOutlet weak var imgMale: UIImageView!
    @IBOutlet weak var imgFemale: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtReligion: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtPincode: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomView.addShadow(location: .top, color: UIColor.black, opacity: 0.3, radius: 5.0)
        
        imgFemale.image = nil
        imgFemale.backgroundColor = UIColor.white
        imgFemale.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
        
        addDoneButtonOnKeyboard()
        
        // Do any additional setup after loading the view.
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
        imgFemale.image = nil
        imgFemale.backgroundColor = UIColor.white
        imgFemale.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
    }
    func FemaleRadioButton()
    {
        imgFemale.image = UIImage(named: "radio-on")
        imgFemale.removeImageborder()
        Gender = "Female"
        imgMale.image = nil
        imgMale.backgroundColor = UIColor.white
        imgMale.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
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
                udefault.set(true, forKey: isDetails)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let signIn = storyboard.instantiateViewController(withIdentifier: "signIn") as! SignIn
                self.present(signIn, animated: true, completion: nil)
            }
        }
        
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
        txtReligion.inputAccessoryView = doneToolbar
        txtAddress.inputAccessoryView = doneToolbar
        txtArea.inputAccessoryView = doneToolbar
        txtPincode.inputAccessoryView = doneToolbar
        
        
    }
    @objc func cancelKeyboard(){
        self.view.endEditing(true)
        
    }
    
    
    @IBAction func txtPincodeTapped(_ sender: UITextField) {
        self.view.frame.origin.y -= 270
    }
    
    @IBAction func txtPincodeEdited(_ sender: UITextField) {
        self.view.frame.origin.y += 270
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
