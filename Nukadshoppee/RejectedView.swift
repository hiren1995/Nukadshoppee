//
//  RejectedView.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import Alamofire


class RejectedView: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var rejectedTable: UITableView!
    @IBOutlet weak var lblNoRejected: UILabel!
    
    //let companyname = ["NukadShopee Affilate Bronze","NukadShopee"]
    //let claimed = ["Claimed on: 8 Jan,2018 02:22 PM","Claimed on: 10 Jan,2018 02:22 PM"]
    //let amtVal = ["588","700"]
    
    var count = 0
     var tempRejected = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rejectedTable.delegate = self
        rejectedTable.dataSource = self
        
        lblNoRejected.isHidden = true
        
         //getTransactionDetails()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        count = 0
        tempRejected = []
        rejectedTable.reloadData()
        getTransactionDetails()
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return companyname.count
        
        if(count == 0)
        {
            lblNoRejected.isHidden = false
        }
        else
        {
            lblNoRejected.isHidden = true
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = rejectedTable.dequeueReusableCell(withIdentifier: "rejectedCell", for: indexPath) as! RejectedCell
        
        /*
        cell.lblShopName.text = companyname[indexPath.row]
        cell.lblClaimed.text = claimed[indexPath.row]
        cell.lblAmtValue.text = amtVal[indexPath.row]
        */
        
        if(DictTransaction["transaction_details"][indexPath.row]["claim_status"].intValue == 3 || DictTransaction["transaction_details"][indexPath.row]["claim_status"].intValue == 4)
        {
            cell.lblShopName.text = tempRejected[indexPath.row]["shop_name"].stringValue
            cell.lblClaimed.text = "Claimed on :" + StringToDateAndString(dateStr: tempRejected[indexPath.row]["claim_cashback_validity"].stringValue)
            cell.lblAmtValue.text = tempRejected[indexPath.row]["amount"].stringValue
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
        
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
                        if(DictTransaction["transaction_details"][i]["claim_status"].intValue == 3 || DictTransaction["transaction_details"][i]["claim_status"].intValue == 4)
                        {
                            self.count = self.count + 1
                            self.tempRejected.append(DictTransaction["transaction_details"][i])
                        }
                    }
                    
                    self.rejectedTable.reloadData()
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
