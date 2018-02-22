//
//  BanksList.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 25/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import Alamofire



class BanksList: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    let names = ["ABC","XYZ","PQR"]
    let banks = ["Bank of India","Bank of Baroda","Bank of India"]
    let accounts = ["XXXXX1234","XXXXX1122","XXXXX1231"]
    
    var tempDict = JSON()
    
    var taxAmount = Float()
    var chargeAmount = Float()
    var otherAmount = Float()
    var payAmount = Float()
    var requestAmount = Float()
    
    var indexPathValue = Int()
    
    @IBOutlet weak var BankTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BankTableView.dataSource = self
        BankTableView.delegate = self
        
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return names.count
        
        return tempDict["bank_list"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = BankTableView.dequeueReusableCell(withIdentifier: "bankCell", for: indexPath) as! BankCell
        
        //cell.cellView.addBorderShadow()
        //cell.lblName.text = names[indexPath.row]
        //cell.lblBankName.text = banks[indexPath.row]
        //cell.lblAccountNumber.text = accounts[indexPath.row]
        
        cell.cellView.addBorderShadow()
        cell.lblName.text = tempDict["bank_list"][indexPath.row]["bank_app_user_name"].stringValue
        cell.lblBankName.text = tempDict["bank_list"][indexPath.row]["bank_name"].stringValue
        cell.lblAccountNumber.text = tempDict["bank_list"][indexPath.row]["bank_acc_no"].stringValue
        
        cell.btnDelete.tag = indexPath.row
        
        cell.btnDelete.addTarget(self, action: #selector(btnDelete(sender:)), for: .touchUpInside)
        cell.btnEdit.addTarget(self, action: #selector(btnEdit(sender:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        let RequestAmtParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String ,"bank_id" : tempDict["bank_list"][indexPath.row]["bank_id"].intValue , "tax" : taxAmount , "requested_amount" : requestAmount , "bank_charge" : otherAmount,"admin_charge": chargeAmount,"net_payable":payAmount]
        
        Alamofire.request(WithdrawalAPI, method: .post, parameters: RequestAmtParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                let tempRequestDict = JSON(response.result.value)
                
                if(tempRequestDict["status"] == "success")
                {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let transactionsView = storyboard.instantiateViewController(withIdentifier: "transactionsView") as! TransactionsView
                    transactionsView.TransactionPageFlag = 1
                    self.present(transactionsView, animated: true, completion: nil)
                    
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }

    @IBAction func btnAddNew(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bankDetails = storyboard.instantiateViewController(withIdentifier: "bankDetails") as! BankDetails
        self.present(bankDetails, animated: true, completion: nil)
        
    }
    
    func loadData()
    {
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        let GetBankListParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String ]
        
        Alamofire.request(GetBankListAPI, method: .post, parameters: GetBankListParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                self.tempDict = JSON(response.result.value)
                
                if(self.tempDict["status"] == "success")
                {
                    
                   self.BankTableView.reloadData()
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
    }
    
    @objc func btnDelete(sender : UIButton)
    {
        let DeleteBankAlert = UIAlertController(title: "Delete Bank ?", message: "Are You Sure You Want To Delete Bank.", preferredStyle: UIAlertControllerStyle.alert)
        
        DeleteBankAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            
            let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
            let DeleteBankParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String  ,"bank_id" : self.tempDict["bank_list"][sender.tag]["bank_id"].stringValue]
            
            Alamofire.request(deleteBankAPI, method: .post, parameters: DeleteBankParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                if(response.result.value != nil)
                {
                    Spinner.hide(animated: true)
                    
                    print(JSON(response.result.value))
                    
                    let BankdeletetempDict = JSON(response.result.value)
                    
                    if(BankdeletetempDict["status"] == "success")
                    {
                        
                        self.viewDidLoad()
                    }
                    
                }
                else
                {
                    Spinner.hide(animated: true)
                    self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                }
            })
           
        }))
        
        DeleteBankAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
            
            print("Delete Cancelled")
            
        }))
        
        present(DeleteBankAlert, animated: true, completion: nil)
    }
    
    @objc func btnEdit(sender : UIButton)
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bankDetails = storyboard.instantiateViewController(withIdentifier: "bankDetails") as! BankDetails
        bankDetails.EditBankDetailsFlag = 1
        bankDetails.bankDetails = tempDict["bank_list"][sender.tag]
        self.present(bankDetails, animated: true, completion: nil)
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
