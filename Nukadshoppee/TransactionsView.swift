//
//  TransactionsView.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import PageMenu
import MBProgressHUD
import Alamofire
import SwiftyJSON


class TransactionsView: UIViewController {

    @IBOutlet weak var lblAmount: UILabel!

    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblAmount.text = rupee
        loadData()
        
        loadTabBarStrip()
        
        // Do any additional setup after loading the view.
    }

    func loadTabBarStrip()
    {
        var controllerArray : [UIViewController] = []
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let pendingView : UIViewController = storyboard.instantiateViewController(withIdentifier: "pendingView") as! PendingView
        pendingView.title = "Pending"
        controllerArray.append(pendingView)
        
        let approvedView : UIViewController = storyboard.instantiateViewController(withIdentifier: "approvedView") as! ApprovedView
        approvedView.title = "Approved"
        controllerArray.append(approvedView)
        
        let rejectedView : UIViewController = storyboard.instantiateViewController(withIdentifier: "rejectedView") as! RejectedView
        rejectedView.title = "Rejected"
        controllerArray.append(rejectedView)
        
        let withdrawalView : UIViewController = storyboard.instantiateViewController(withIdentifier: "withdrawalView") as! WithdrawalView
        withdrawalView.title = "Withdraw"
        controllerArray.append(withdrawalView)
        
        var parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1)
        ]
        
        //pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        pageMenu =  CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 170, width: self.view.frame.width, height: self.view.frame.height-170), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
        
      

    }
    @IBAction func btnBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData()
    {
        
            let GetBalanceParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String]
            
            //print(GetBalanceParameters)
            
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
                        
                        //self.getTransactionDetails()
                    }
                        
                    else
                    {
                        if(tempDict["status_code"].intValue == 0)
                        {
                            self.lblAmount.text = rupee + "  " + tempDict["wallet_balance"].stringValue
                            //self.getTransactionDetails()
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
