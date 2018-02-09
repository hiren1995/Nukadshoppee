//
//  WithdrawalView.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

class WithdrawalView: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var WithdrawalTable: UITableView!
    @IBOutlet weak var lblNoApproved: UILabel!
    
    //let claims = ["Date of Claim : 8 Jan,2018 12:35 PM" , "Date of Claim : 10 Jan,2018 12:35 PM","Date of Claim : 14 Jan,2018 12:35 PM","Date of Claim : 20 Jan,2018 12:35 PM","Date of Claim : 1 Jan,2018 12:35 PM"]
    //let status = ["Status : Pending","Status : Pending","Status : Pending","Status : Pending","Status : Pending"]
    //let reference = ["Reference Id: -","Reference Id: -","Reference Id: -","Reference Id: -","Reference Id: -"]
    //let amtvalue = ["100","100","100","100","100"]
    
    var count = 0
    
    var tempWithdrawal = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WithdrawalTable.delegate = self
        WithdrawalTable.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        count = 0
        tempWithdrawal = []
        WithdrawalTable.reloadData()
        getTransactionDetails()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return claims.count
        
        if(count == 0)
        {
            lblNoApproved.isHidden = false
        }
        else
        {
            lblNoApproved.isHidden = true
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = WithdrawalTable.dequeueReusableCell(withIdentifier: "withdrawalCell", for: indexPath) as! WithdrawalCell
        
        /*
        cell.lblDateOfClaim.text = claims[indexPath.row]
        //cell.lblDateOfClaim.pushTransition(duration: 5)
        cell.lblStatus.text = status[indexPath.row]
        cell.lblReferenceId.text = reference[indexPath.row]
        cell.lblAmountValue.text = amtvalue[indexPath.row]
        */
        
        cell.lblDateOfClaim.text = "Dateof Claim : " + StringToDateAndString(dateStr: tempWithdrawal[indexPath.row]["transaction_time"].stringValue)
        cell.lblDateOfClaim.marqueeType = .MLContinuous
        
        if(tempWithdrawal[indexPath.row]["withdrawal_status"].intValue == 1)
        {
            cell.lblStatus.text = "Status : Pending"
        }
        else
        {
            cell.lblStatus.text = "Status : Approved"
        }
        
        if(tempWithdrawal[indexPath.row]["refrence_id"].stringValue == "")
        {
            cell.lblReferenceId.text = "Reference Id : -"
        }
        else
        {
            cell.lblReferenceId.text = "Reference Id : " + tempWithdrawal[indexPath.row]["refrence_id"].stringValue
        }
        
        
        cell.lblAmountValue.text = tempWithdrawal[indexPath.row]["requested_amount"].stringValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
    
    func getTransactionDetails()
    {
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        let GetTransactionsParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String]
        
        Alamofire.request(GETTansactionDetailsAPI, method: .post, parameters: GetTransactionsParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                DictTransaction = JSON(response.result.value!)
                
                print(DictTransaction)
                
                if(DictTransaction["status"] == "success")
                {
                    for i in 0...DictTransaction["transaction_details"].count - 1
                    {
                        if(DictTransaction["transaction_details"][i]["withdrawal_id"] != JSON.null || DictTransaction["transaction_details"][i]["claim_status"] == JSON.null)
                        {
                            self.count = self.count + 1
                            self.tempWithdrawal.append(DictTransaction["transaction_details"][i])
                        }
                    }
                    
                    self.WithdrawalTable.reloadData()
                }
                    
                else
                {
                    
                    self.showAlert(title: "Alert", message: "Something went wrong while Getting Transactions Details")
                    
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
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
