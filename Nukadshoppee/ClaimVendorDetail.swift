//
//  ClaimVendorDetail.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 22/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import CropViewController
import Alamofire
import MBProgressHUD
import SwiftyJSON



class ClaimVendorDetail: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CropViewControllerDelegate {

    var imagePicker = UIImagePickerController()
    var imgData = Data()
    
    var CashBackDetails = JSON()
    
    @IBOutlet weak var imgPicSelected: UIImageView!
    @IBOutlet weak var txtInvoiceNumber: UITextField!
    @IBOutlet weak var txtAmountValue: UITextField!
    @IBOutlet weak var lblVendorName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgPicSelected.isHidden = true
        addDoneButtonOnKeyboard()
        
        loadData()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnUploadImg(_ sender: UIButton) {
        
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
            
            self.dismiss(animated: true, completion: nil)
            let cropViewController = CropViewController(image: image)
            cropViewController.delegate = self
            present(cropViewController, animated: true, completion: nil)
            
            
        } else{
            print("Something went wrong")
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
        imgPicSelected.isHidden = false
        
        imgData = UIImageJPEGRepresentation(image, 0.5)!
        
        //write the code for storing the image data that is selected
        
        dismiss(animated: true, completion: nil)
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
        
        txtInvoiceNumber.inputAccessoryView = doneToolbar
        txtAmountValue.inputAccessoryView = doneToolbar
       
    }
    @objc func cancelKeyboard(){
        self.view.endEditing(true)
        
    }
    
    @IBAction func btnSend(_ sender: Any) {
        
        if(txtInvoiceNumber.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Invoice Number")
        }
        else if(txtAmountValue.text == "")
        {
             self.showAlert(title: "Alert", message: "Please Amount")
        }
        else if(imgData.isEmpty)
        {
            self.showAlert(title: "Alert", message: "Please Select Invoice Image")
        }
        else
        {
           if(Int(txtAmountValue.text!)! < CashBackDetails["minimum_invoice"].intValue)
           {
                self.showAlert(title: "Alert", message: "Please Enter Amount greater than" + CashBackDetails["minimum_invoice"].stringValue)
           }
           else
           {
                    let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
            
                    let CashbackParameters:Parameters = ["app_user_id" : udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String , "offer_id" : CashBackDetails["offer_id"].intValue , "claim_amount" : txtAmountValue.text! , "invoice_number" : txtInvoiceNumber.text! ]
            
                    print(CashbackParameters)
            
                    Alamofire.upload(multipartFormData: { (multipartFormData) in
                        
                        for (key, value) in CashbackParameters {
                            multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                        }
                        
                        multipartFormData.append(self.imgData, withName: "claim_cash_back_img", fileName: "image.jpg", mimeType: "image/jpg")
                        
                    },to: ClaimCashAPI, encodingCompletion: { (result) in
                        
                        switch result{
                        case .success(let upload, _, _):
                            upload.responseJSON { response in
                                print("Succesfully uploaded")
                                spinnerActivity.hide(animated: true)
                                print(response.result.value)
                                
                                let tempDict = JSON(response.result.value)
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let claimStatus = storyboard.instantiateViewController(withIdentifier: "claimStatus") as! ClaimStatus
                                claimStatus.ClaimStatusDetails = tempDict
                                claimStatus.shopID = self.CashBackDetails["shop_id"].intValue
                                self.present(claimStatus, animated: true, completion: nil)
                                
                            }
                        case .failure(let error):
                            print("Error in upload: \(error.localizedDescription)")
                            spinnerActivity.hide(animated: true)
                            self.showAlert(title: "Alert", message: "Error in Claiming")
                            
                        }
                        
                    })
           }
            
            
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let claimStatus = storyboard.instantiateViewController(withIdentifier: "claimStatus") as! ClaimStatus
            //self.present(claimStatus, animated: true, completion: nil)
        }
       
    }
    
    @IBAction func txtAmtEditStart(_ sender: UITextField) {
        self.view.frame.origin.y -= 100
    }
    
    @IBAction func txtAmtEditEnd(_ sender: UITextField) {
        self.view.frame.origin.y += 100
    }
    
    @IBAction func btnback(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboard = storyboard.instantiateViewController(withIdentifier: "dashboard") as! Dashboard
        self.present(dashboard, animated: true, completion: nil)
    }
    
    func loadData()
    {
        lblVendorName.text =  CashBackDetails["shop_name"].stringValue
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
