//
//  QRCodeScanningLogicView.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import AVFoundation
import MBProgressHUD
import Alamofire
import SwiftyJSON

class QRCodeScanningLogicView: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

     var captureDevice:AVCaptureDevice?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    
    let codeFrame:UIView = {
        let codeFrame = UIView()
        codeFrame.layer.borderColor = UIColor.green.cgColor
        codeFrame.layer.borderWidth = 2
        codeFrame.frame = CGRect.zero
        codeFrame.translatesAutoresizingMaskIntoConstraints = false
        return codeFrame
    }()

    let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Scanner"
        view.backgroundColor = .white
        
        captureDevice = AVCaptureDevice.default(for: .video)
        // Check if captureDevice returns a value and unwrap it
        
        if let captureDevice = captureDevice {
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                
                captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39] //AVMetadataObject.ObjectType
                
                captureSession.startRunning()
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                //videoPreviewLayer?.frame = view.layer.bounds
                videoPreviewLayer?.frame = CGRect(x: 0, y: 121, width: view.layer.bounds.width, height: view.layer.bounds.height - 121)
                view.layer.addSublayer(videoPreviewLayer!)
                
            } catch {
                print("Error Device Input")
            }
            
        }
        

        // Do any additional setup after loading the view.
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count == 0 {
        
            codeFrame.frame = CGRect.zero
            print("No Input Detected")
            
            return
        }
        else
        {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            
            guard let stringCodeValue = metadataObject.stringValue else { return }
            print(stringCodeValue)
            
            view.addSubview(codeFrame)
            guard let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
            codeFrame.frame = barcodeObject.bounds
            
            validateQR(shopId: stringCodeValue)
            
            self.captureSession.stopRunning()
        }
        
        
        
        // Create some label and assign returned string value to it
        //codeLabel.text = stringCodeValue
        // Perform further logic needed (ex. redirect to other ViewController)

    }
    @IBAction func btnBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func validateQR(shopId : String)
    {
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        let SacnQRParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String , "shop_id" : shopId]
        
        Alamofire.request(SacnQRcodeAPI, method: .post, parameters: SacnQRParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                let tempDict = JSON(response.result.value)
                
                if(tempDict["status_code"].intValue == 1)
                {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let claimVendorDetail = storyboard.instantiateViewController(withIdentifier: "claimVendorDetail") as! ClaimVendorDetail
                    claimVendorDetail.CashBackDetails = tempDict["qr_code_details"]
                    self.present(claimVendorDetail, animated: true, completion: nil)
                }
                else
                {
                    self.showAlert(title: "Message", message: tempDict["message"].stringValue)
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let claimVendorDetail = storyboard.instantiateViewController(withIdentifier: "claimVendorDetail") as! ClaimVendorDetail
        //self.present(claimVendorDetail, animated: true, completion: nil)
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
