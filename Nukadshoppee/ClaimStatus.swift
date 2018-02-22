//
//  ClaimStatus.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 22/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import AARatingBar
import MBProgressHUD
import Alamofire
import SwiftyJSON

class ClaimStatus: UIViewController {

    var approved:Bool = false
    
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var imgbg: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgOops: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var ratingBar: AARatingBar!
    @IBOutlet weak var txtRatingDesc: UITextField!
    @IBOutlet weak var lblShopName: UILabel!
    
    var ClaimStatusDetails = JSON()
    var shopID = Int()
    var shopName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        addDoneButtonOnKeyboard()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnClose(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboard = storyboard.instantiateViewController(withIdentifier: "dashboard") as! Dashboard
        self.present(dashboard, animated: true, completion: nil)
    }
    
    @IBAction func btnCancelClicked(_ sender: UIButton) {
        
        alphaView.isHidden = true
        ratingView.isHidden = true
        
    }
    
    @IBAction func btnOkClicked(_ sender: UIButton) {
        
        if(txtRatingDesc.text == "")
        {
            self.showAlert(title: "Alert", message: "Please Enter Rating Description")
        }
        else
        {
            
            let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
            let RatingParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String , "shop_id": shopID,"rating_description": txtRatingDesc.text!,"rating_star": ratingBar.value]
            
            Alamofire.request(GiveRatingAPI, method: .post, parameters: RatingParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                if(response.result.value != nil)
                {
                    Spinner.hide(animated: true)
                    
                    print(JSON(response.result.value))
                    
                    let tempDict = JSON(response.result.value)
                    
                    if(tempDict["status"] == "success")
                    {
                        self.alphaView.isHidden = true
                        self.ratingView.isHidden = true
                    }
                    
                }
                else
                {
                    Spinner.hide(animated: true)
                    self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                }
            })
            
            //alphaView.isHidden = true
            //ratingView.isHidden = true
        }
        
    }
    
    func loadData()
    {
        
        ratingView.isHidden = false
        
        lblShopName.text = shopName
        
        let rupee = "\u{20B9}"
        
        lblAmount.text = rupee + ClaimStatusDetails["wallet_balance"].stringValue
        
        if(ClaimStatusDetails["status_code"].intValue == 1)
        {
            approved = true
        }
        
        ApprovedStatus()
    }
    func ApprovedStatus()
    {
        
        
        if approved
        {
            imgbg.image = UIImage(named: "bg_congo")
            txtMessage.text = "You got Rs." + ClaimStatusDetails["claim_data"][0]["cash_back_amount"].stringValue + "cash back (validity " + ClaimStatusDetails["claim_data"][0]["claim_cashback_validity"].stringValue + ").It will be credited to your account after approval of vendor."
            lblStatus.text = "Congratulations!!"
            imgOops.isHidden = true
        }
        else
        {
            imgbg.image = UIImage(named: "bg_oops")
            txtMessage.text = "Sorry your cash back claim has been rejected because you had already made 2 claims from same shopkeeper in last 30 days."
            
            lblStatus.text = "Oops!!!"
            imgOops.isHidden = false
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
        
        txtRatingDesc.inputAccessoryView = doneToolbar
        
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
