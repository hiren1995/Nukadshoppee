//
//  RejectedView.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class RejectedView: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var rejectedTable: UITableView!
    
    let companyname = ["NukadShopee Affilate Bronze","NukadShopee"]
    let claimed = ["Claimed on: 8 Jan,2018 02:22 PM","Claimed on: 10 Jan,2018 02:22 PM"]
    let amtVal = ["588","700"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rejectedTable.delegate = self
        rejectedTable.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyname.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = rejectedTable.dequeueReusableCell(withIdentifier: "rejectedCell", for: indexPath) as! RejectedCell
        
        cell.lblShopName.text = companyname[indexPath.row]
        cell.lblClaimed.text = claimed[indexPath.row]
        cell.lblAmtValue.text = amtVal[indexPath.row]
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
        
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
