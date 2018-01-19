//
//  Vendor.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 18/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class Vendor: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var vendorTable: UITableView!
    
    let vendorName = ["Gayatri Electronics"]
    let vendorArea = ["Nizampura"]
    let vendorDealsin = ["Test"]
    let VendorRating = ["10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vendorTable.dataSource = self
        vendorTable.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vendorName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = vendorTable.dequeueReusableCell(withIdentifier: "vendorCell", for: indexPath) as! VendorCell
        
        cell.cellView.addBorderShadow()
        cell.vendorName.text = vendorName[indexPath.row]
        cell.vendorArea.text = vendorArea[indexPath.row]
        cell.vendorDealsIn.text = vendorDealsin[indexPath.row]
        cell.vendorRating.text = VendorRating[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
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
