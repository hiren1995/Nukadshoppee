//
//  UpdateProfile.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 23/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import MBProgressHUD
import CropViewController

var UpdatedGender:String = "Male"

class UpdateProfile: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CropViewControllerDelegate{
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var imgMale: UIImageView!
    @IBOutlet weak var imgFemale: UIImageView!
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var txtPincode: UITextField!
    @IBOutlet weak var txtReligion: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtOtherReligion: UITextField!
    
    var DateString = String()
    var DataPickerView = UIPickerView()
    var activeTextView: UITextField?
    var imagePicker = UIImagePickerController()
    
    var ReligionDict = JSON()
    var StateDict = JSON()
    var CityDict = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         bottomView.addShadow(location: .top, color: UIColor.black, opacity: 0.3, radius: 5.0)
        
        imgFemale.image = nil
        imgFemale.backgroundColor = UIColor.white
        imgFemale.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
        
        DataPickerView.delegate = self
        DataPickerView.dataSource = self
        
        txtOtherReligion.isHidden = true
        
        loadData()
        
        addDoneButtonOnKeyboard()
        addDoneStatePicker()
        addDoneReligionPicker()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
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
    
    @IBAction func txtPincodeTapped(_ sender: UITextField) {
        self.view.frame.origin.y -= 270
    }
    
    @IBAction func txtPincodeEdited(_ sender: UITextField) {
        self.view.frame.origin.y += 270
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
        txtReligion.inputAccessoryView = doneToolbar
        txtAddress.inputAccessoryView = doneToolbar
        txtArea.inputAccessoryView = doneToolbar
        txtPincode.inputAccessoryView = doneToolbar
        //txtState.inputAccessoryView = doneToolbar
        txtCity.inputAccessoryView = doneToolbar
        txtOtherReligion.inputAccessoryView = doneToolbar
    }
    @objc func cancelKeyboard(){
        self.view.endEditing(true)
        
    }
    
    func loadData()
    {
        txtName.text = UserData["app_user_name"].stringValue
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: UserData["app_user_dob"].stringValue)
        
        let normalDateFormatter = DateFormatter()
        normalDateFormatter.dateStyle = .long
        txtDOB.text = normalDateFormatter.string(from: date!)
        
        txtReligion.text = UserData["religion_name"].stringValue
        //txtAddress.text = UserData["manjalpur"].stringValue
        txtArea.text = UserData["app_user_area"].stringValue
        txtState.text = UserData["state_name"].stringValue
        txtCity.text = UserData["city_name"].stringValue
        txtPincode.text = UserData["app_user_pincode"].stringValue
        txtAddress.text = UserData["app_user_address"].stringValue
        
        
        if(UserData["app_user_gender"].intValue == 1)
        {
            MaleRadioButton()
        }
        else
        {
            FemaleRadioButton()
        }
        
        
        
        if(UserData["app_user_profilepic"].stringValue != "")
        {
            KingfisherManager.shared.downloader.downloadImage(with: NSURL(string: UserData["app_user_profilepic"].stringValue)! as URL, retrieveImageTask: RetrieveImageTask.empty, options: [], progressBlock: nil, completionHandler: { (image,error, imageURL, imageData) in
                
                
                self.imgProfilePic.image = image
                
            })
        }
        
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
                    /*
                    var m = [String]()
                    for i in 0...self.ReligionDict["bank_list"].count - 1
                    {
                       m.insert(self.ReligionDict["bank_list"][i]["religion_name"].stringValue, at: i)
                    }
                    m.append("other")
                    print(m)
                    */
                    
                    let x:JSON = [["religion_name" : "Other" , "religion_id" : "0"]]
                    
                    do
                    {
                        //let p = try self.ReligionDict["bank_list"].merged(with: x)
                        //print(p)
                        
                        self.ReligionDict["bank_list"] = try self.ReligionDict["bank_list"].merged(with: x)
                        
                    }catch
                    {
                        print(error)
                    }
                    
                    //self.ReligionDict["bank_list"].merged(with: x)
                   
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
        
        if(UserData["app_user_profilepic"].stringValue != "")
        {
            KingfisherManager.shared.downloader.downloadImage(with: NSURL(string: UserData["app_user_profilepic"].stringValue)! as URL, retrieveImageTask: RetrieveImageTask.empty, options: [], progressBlock: nil, completionHandler: { (image,error, imageURL, imageData) in
                
                
                self.imgProfilePic.image = image
                
            })
        }
        
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
    @IBAction func btnProfileImage(_ sender: UIButton) {
        
        var alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        var cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        var gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        
        imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            alertWarning.show()
        }
    }
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            //profileImg.image = image
            
            self.dismiss(animated: true, completion: nil)
            let cropViewController = CropViewController(image: image)
            cropViewController.delegate = self
            present(cropViewController, animated: true, completion: nil)
            //self.dismiss(animated: true, completion: nil)
            
        } else{
            print("Something went wrong")
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
        imgProfilePic.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if(txtName.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter your Name")
        }
        else if(txtDOB.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter your Date of Birth")
        }
        else if(txtReligion.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter your Religion")
        }
        else if(txtAddress.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter your Address")
        }
        else if(txtArea.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter your Area")
        }
        else if(txtState.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter your State")
        }
        else if(txtCity.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter your City")
        }
        else if(txtPincode.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter your Pincode")
        }
        else
        {
            let imgData = UIImageJPEGRepresentation(imgProfilePic.image!, 0.1)
            
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            
            let date = dateFormatter.date(from: txtDOB.text!)
            
            var dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "yyyy-MM-dd"
            DateString = dateFormatter2.string(from: date!)
            
            let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
            
            let updateParameters:Parameters = ["app_user_id" : udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String , "app_user_name" : txtName.text! , "app_user_dob" : DateString , "app_user_gender" : GenderId , "app_user_religion":udefault.value(forKey: ReligionID) as! Int , "app_user_address":txtAddress.text!,"app_user_area":txtArea.text!,"app_user_state":udefault.value(forKey: StateId) as! Int,"app_user_city":udefault.value(forKey: CityId) as! Int,"app_user_pincode":txtPincode.text!]
            
            print(updateParameters)
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in updateParameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if let data = imgData{
                    
                    multipartFormData.append(data, withName: "app_user_profilepic", fileName: "image.jpg", mimeType: "image/jpg")
                    
                }
                
            },to: UpdateProfileAPI, encodingCompletion: { (result) in
                
                switch result{
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print("Succesfully uploaded")
                        spinnerActivity.hide(animated: true)
                        print(response.result.value)
                        
                        let tempDict = JSON(response.result.value!)
                        
                        print(tempDict["updated_user_details"][0])
                        
                        UserData = tempDict["updated_user_details"][0]
                        
                        self.viewDidLoad()
                        
                    }
                case .failure(let error):
                    print("Error in upload: \(error.localizedDescription)")
                    spinnerActivity.hide(animated: true)
                    self.showAlert(title: "Alert", message: "Error in Uploading")
                    
                }
                
            })
        }
       
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
