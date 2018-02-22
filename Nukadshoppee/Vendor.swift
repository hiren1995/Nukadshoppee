//
//  Vendor.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 18/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import MBProgressHUD

class Vendor: UIViewController,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate{
    
    @IBOutlet weak var vendorTable: UITableView!
    
    let vendorName = ["Gayatri Electronics"]
    let vendorArea = ["Nizampura"]
    let vendorDealsin = ["Test"]
    let VendorRating = ["10"]
    
    var tempDict = JSON()
    var locationManager = CLLocationManager()
    var currentLocataion = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vendorTable.dataSource = self
        vendorTable.delegate = self
        
        //getCurrentLocation()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        getCurrentLocation()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return vendorName.count
        return tempDict["shop_list"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = vendorTable.dequeueReusableCell(withIdentifier: "vendorCell", for: indexPath) as! VendorCell
        
        /*
        cell.cellView.addBorderShadow()
        cell.vendorName.text = vendorName[indexPath.row]
        cell.vendorArea.text = vendorArea[indexPath.row]
        cell.vendorDealsIn.text = vendorDealsin[indexPath.row]
        cell.vendorRating.text = VendorRating[indexPath.row]
        cell.selectionStyle = .none
        */
        
        cell.cellView.addBorderShadow()
        cell.vendorName.text = tempDict["shop_list"][indexPath.row]["shop_name"].stringValue
        cell.vendorArea.text = tempDict["shop_list"][indexPath.row]["shop_area"].stringValue
        cell.vendorDealsIn.text = tempDict["shop_list"][indexPath.row]["deals_in"].stringValue
        cell.vendorRating.text = tempDict["shop_list"][indexPath.row]["0"].stringValue
        cell.selectionStyle = .none
        
        cell.vendorCall.tag = indexPath.row
        cell.vendorCall.addTarget(self, action: #selector(makeCall(sender:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vendorDetails = storyboard.instantiateViewController(withIdentifier: "vendorDetails") as! VendorDetails
        vendorDetails.tempDict = tempDict["shop_list"][indexPath.row]
        self.present(vendorDetails, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    func loadData()
    {
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        let GetVendorsParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String , "app_user_current_lat" : currentLocataion.coordinate.latitude , "app_user_current_lng" : currentLocataion.coordinate.longitude]
        
        Alamofire.request(GetVendorsAPI, method: .post, parameters: GetVendorsParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                self.tempDict = JSON(response.result.value)
                
                if(self.tempDict["status"] == "success")
                {
                    self.vendorTable.reloadData()
                }
                else
                {
                    
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
    }
    
    func getCurrentLocation()
    {
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways)
        {
            currentLocataion = locationManager.location!
            
            print(currentLocataion.coordinate.latitude)
            print(currentLocataion.coordinate.longitude)
            
            loadData()
        }
    }
    
    @objc func makeCall(sender: UIButton)
    {
        let contact = tempDict["shop_list"][sender.tag]["owner_contactno"].stringValue
        if let url = URL(string: "tel://\(contact)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
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
