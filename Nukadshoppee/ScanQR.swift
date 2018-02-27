//
//  ScanQR.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 18/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class ScanQR: UIViewController {

    
    @IBOutlet weak var lblAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblAmount.text = rupee
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }

    @IBAction func btnScanQR(_ sender: UIButton) {
        
        let verified = UserDefaults.standard.bool(forKey: isEmailVerified)
        
        if verified
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let qrCodeScanningLogicView = storyboard.instantiateViewController(withIdentifier: "qrCodeScanningLogicView") as! QRCodeScanningLogicView
            self.present(qrCodeScanningLogicView, animated: true, completion: nil)
        }
        else
        {
            
            let vrifyEmailAlert = UIAlertController(title: "Verify Email", message: "You are registered User but Your Email is not Verified Please Verify that first and Login again.", preferredStyle: UIAlertControllerStyle.alert)
            
            vrifyEmailAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                
                if (UserData["app_user_email"].stringValue != "")
                {
                    let resendEmailParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_email" : UserData["app_user_email"].stringValue , "app_user_contact_number" : UserData["app_user_contact_number"].stringValue]
                    
                    
                    let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
                    
                    Alamofire.request(ResendEmailAPI, method: .post, parameters: resendEmailParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                        if(response.result.value != nil)
                        {
                            Spinner.hide(animated: true)
                            
                            print(JSON(response.result.value))
                            
                            let tempDict = JSON(response.result.value!)
                            
                            if(tempDict["status"] == "success")
                            {
                                self.showAlert(title: "Alert", message: "Email Verification mail sent Successfully")
                            }
                                
                            else
                            {
                                
                                self.showAlert(title: "Alert", message: "Something went wrong while sending Mail")
                                
                            }
                            
                        }
                        else
                        {
                            Spinner.hide(animated: true)
                            self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                        }
                    })
                }
                
                
            }))
            
            vrifyEmailAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
                
                print("Verification Cancelled")
                
            }))
            
            present(vrifyEmailAlert, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func btnWallet(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let wallet = storyboard.instantiateViewController(withIdentifier: "wallet") as! Wallet
        self.present(wallet, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData()
    {
        if(udefault.value(forKey: UserId) != nil && udefault.value(forKey: UserToken) != nil)
        {
            let GetBalanceParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String]
            
            print(GetBalanceParameters)
            
            let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
            
            Alamofire.request(GetWalletBalanceAPI, method: .post, parameters: GetBalanceParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                if(response.result.value != nil)
                {
                    Spinner.hide(animated: true)
                    
                    print(JSON(response.result.value))
                    
                    let tempDict = JSON(response.result.value!)
                    
                    if(tempDict["status"] == "success")
                    {
                        self.lblAmount.text = rupee + "  " + tempDict["wallet_balance"].stringValue
                    }
                        
                    else
                    {
                        if(tempDict["status_code"].intValue == 0)
                        {
                            self.lblAmount.text = rupee + "  " + tempDict["wallet_balance"].stringValue
                        }
                        else
                        {
                            self.showAlert(title: "Alert", message: "Something went wrong while Getting Balance Details")
                        }
                        
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
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signIn = storyboard.instantiateViewController(withIdentifier: "signIn") as! SignIn
            self.present(signIn, animated: true, completion: nil)
        }
        
        
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
