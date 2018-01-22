//
//  WithdrawalView.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class WithdrawalView: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var WithdrawalTable: UITableView!
    
    let claims = ["Date of Claim : 8 Jan,2018 12:35 PM" , "Date of Claim : 10 Jan,2018 12:35 PM","Date of Claim : 14 Jan,2018 12:35 PM","Date of Claim : 20 Jan,2018 12:35 PM","Date of Claim : 1 Jan,2018 12:35 PM"]
    let status = ["Status : Pending","Status : Pending","Status : Pending","Status : Pending","Status : Pending"]
    let reference = ["Reference Id: -","Reference Id: -","Reference Id: -","Reference Id: -","Reference Id: -"]
    let amtvalue = ["100","100","100","100","100"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WithdrawalTable.delegate = self
        WithdrawalTable.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return claims.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = WithdrawalTable.dequeueReusableCell(withIdentifier: "withdrawalCell", for: indexPath) as! WithdrawalCell
        
        cell.lblDateOfClaim.text = claims[indexPath.row]
        //cell.lblDateOfClaim.pushTransition(duration: 5)
        cell.lblStatus.text = status[indexPath.row]
        cell.lblReferenceId.text = reference[indexPath.row]
        cell.lblAmountValue.text = amtvalue[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
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
