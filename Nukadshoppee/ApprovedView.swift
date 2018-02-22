//
//  ApprovedView.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON



class ApprovedView: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var approvedTable: UITableView!
    @IBOutlet weak var lblNoApproved: UILabel!
    
    //let companyname = ["NukadShopee Affilate Bronze","NukadShopee"]
    //let invoice = ["Invoice no: hh88","Invoice no: hh87"]
    //let amt = ["Amount:9469","Amount:9470"]
    //let expires = ["Expires on:20 Jan,2018","Expires on:26 Jan,2018"]
    //let amtVal = ["588","700"]
    
    var count = 0
    
    var tempApproved = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        approvedTable.delegate = self
        approvedTable.dataSource = self
        
        lblNoApproved.isHidden = true
        
        //getTransactionDetails()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        count = 0
        tempApproved = []
        approvedTable.reloadData()
        getTransactionDetails()
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        
        let cell = approvedTable.dequeueReusableCell(withIdentifier: "approvedCell", for: indexPath) as! ApprovedCell

        /*
        cell.lblShopName.text = companyname[indexPath.row]
        cell.lblInoviceNum.text = invoice[indexPath.row]
        cell.lblAmount.text = amt[indexPath.row]
        cell.lblExpires.text = expires[indexPath.row]
        cell.lblAmtValue.text = amtVal[indexPath.row]
        */
        
        if(tempApproved[indexPath.row]["transaction_type"].intValue == 3)
        {
            cell.lblShopName.text = "Refferal Bonus"
            cell.lblInoviceNum.isHidden = true
            cell.lblAmount.isHidden = true
            
        }
        else
        {
            cell.lblShopName.text = tempApproved[indexPath.row]["shop_name"].stringValue
            cell.lblInoviceNum.text = "Inovice no: " + tempApproved[indexPath.row]["claim_cash_back_ticket_no"].stringValue
            cell.lblAmount.text = "Amount:" + tempApproved[indexPath.row]["claim_amount"].stringValue
        }
        
        cell.lblExpires.text = "Expires on: " + StringToDateAndString(dateStr: tempApproved[indexPath.row]["claim_cashback_validity"].stringValue)
        cell.lblAmtValue.text = tempApproved[indexPath.row]["amount"].stringValue
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
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
                        if(DictTransaction["transaction_details"][i]["claim_status"].intValue == 2)
                        {
                            self.count = self.count + 1
                            self.tempApproved.append(DictTransaction["transaction_details"][i])
                        }
                    }
                    
                    self.approvedTable.reloadData()
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
