//
//  ClaimVendorDetail.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 22/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import CropViewController

class ClaimVendorDetail: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CropViewControllerDelegate {

    var imagePicker = UIImagePickerController()
    var imgData = Data()
    
    @IBOutlet weak var imgPicSelected: UIImageView!
    @IBOutlet weak var txtInvoiceNumber: UITextField!
    @IBOutlet weak var txtAmountValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgPicSelected.isHidden = true
        addDoneButtonOnKeyboard()
        
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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let claimStatus = storyboard.instantiateViewController(withIdentifier: "claimStatus") as! ClaimStatus
            self.present(claimStatus, animated: true, completion: nil)
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
