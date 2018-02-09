//
//  Wallet.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

class Wallet: UIViewController {

    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        balanceView.addBorderShadow()
        
        lblInfo.roundTopCorners(radius: 10)
        
        lblAmount.text = rupee
        
        loadData()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnTransactions(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let transactionsView = storyboard.instantiateViewController(withIdentifier: "transactionsView") as! TransactionsView
        self.present(transactionsView, animated: true, completion: nil)
    }
    
    
    @IBAction func btnWithdrawal(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let withdrawalAmount = storyboard.instantiateViewController(withIdentifier: "withdrawalAmount") as! WithdrawalAmount
        self.present(withdrawalAmount, animated: true, completion: nil)
    }
    
    func loadData()
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
