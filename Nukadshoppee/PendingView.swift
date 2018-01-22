//
//  PendingView.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class PendingView: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var pendingTable: UITableView!
    
    let companyname = ["NukadShopee Affilate Bronze","NukadShopee"]
    let invoice = ["Invoice no: hh88","Invoice no: hh87"]
    let amt = ["Amount:9469","Amount:9470"]
    let expires = ["Expires on:20 Jan,2018","Expires on:26 Jan,2018"]
    let amtVal = ["588","700"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pendingTable.delegate = self
        pendingTable.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return companyname.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = pendingTable.dequeueReusableCell(withIdentifier: "pendingCell", for: indexPath) as! PendingCell
        
        cell.lblShopName.text = companyname[indexPath.row]
         cell.lblInoviceNum.text = invoice[indexPath.row]
         cell.lblAmount.text = amt[indexPath.row]
         cell.lblExpires.text = expires[indexPath.row]
         cell.lblAmtValue.text = amtVal[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
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
