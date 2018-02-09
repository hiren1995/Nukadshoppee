//
//  PendingView.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
import Alamofire

var DictTransaction = JSON()

class PendingView: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var pendingTable: UITableView!
    @IBOutlet weak var lblNoPending: UILabel!
    
    //let companyname = ["NukadShopee Affilate Bronze","NukadShopee"]
    //let invoice = ["Invoice no: hh88","Invoice no: hh87"]
    //let amt = ["Amount:9469","Amount:9470"]
    //let expires = ["Expires on:20 Jan,2018","Expires on:26 Jan,2018"]
    //let amtVal = ["588","700"]
    
    var count = 0
     var tempPending = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pendingTable.delegate = self
        pendingTable.dataSource = self
        lblNoPending.isHidden = true
        
        //getTransactionDetails()
       
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        count = 0
        tempPending = []
        pendingTable.reloadData()
        
        getTransactionDetails()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //return companyname.count
        if(count == 0)
        {
            lblNoPending.isHidden = false
        }
        else
        {
            lblNoPending.isHidden = true
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = pendingTable.dequeueReusableCell(withIdentifier: "pendingCell", for: indexPath) as! PendingCell
        
        /*
        cell.lblShopName.text = companyname[indexPath.row]
         cell.lblInoviceNum.text = invoice[indexPath.row]
         cell.lblAmount.text = amt[indexPath.row]
         cell.lblExpires.text = expires[indexPath.row]
         cell.lblAmtValue.text = amtVal[indexPath.row]
        */
        
        if(DictTransaction["transaction_details"][indexPath.row]["claim_status"].intValue == 1)
        {
            cell.lblShopName.text = tempPending[indexPath.row]["shop_name"].stringValue
            cell.lblInoviceNum.text = "Invoice no: " + tempPending[indexPath.row]["claim_cash_back_ticket_no"].stringValue
            cell.lblAmount.text = "Amount: " + tempPending[indexPath.row]["claim_amount"].stringValue
            cell.lblExpires.text = "Expires on: " + StringToDateAndString(dateStr: tempPending[indexPath.row]["claim_cashback_validity"].stringValue)
            cell.lblAmtValue.text = tempPending[indexPath.row]["amount"].stringValue
        }
        
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
                
                if(DictTransaction["status"] == "success")
                {
                    for i in 0...DictTransaction["transaction_details"].count - 1
                    {
                        if(DictTransaction["transaction_details"][i]["claim_status"].intValue == 1)
                        {
                            self.count = self.count + 1
                            self.tempPending.append(DictTransaction["transaction_details"][i])
                        }
                    }
                    
                    print(self.count)
                    
                    self.pendingTable.reloadData()
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
