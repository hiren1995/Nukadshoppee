//
//  TransactionsView.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import PageMenu

class TransactionsView: UIViewController {

    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
