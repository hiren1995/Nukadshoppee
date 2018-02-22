//
//  MoreDetails.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 12/02/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class MoreDetails: UIViewController {

    var strModule = String()
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var txtData: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(strModule == "Promote")
        {
            lblHeader.text = "Promote your business with us"
            let htmltxt = TaxData["promote_business"].stringValue
            txtData.text = htmltxt.htmlToString
            
        }
        else if(strModule == "About")
        {
            lblHeader.text = "About us"
            let htmltxt = TaxData["about_us"].stringValue
            txtData.text = htmltxt.htmlToString
        }
        else if(strModule == "Privacy")
        {
            lblHeader.text = "Privacy policy"
            let htmltxt = TaxData["privacy_policy"].stringValue
            txtData.text = htmltxt.htmlToString
        }
        else
        {
            lblHeader.text = "Terms & conditions"
            let htmltxt = TaxData["terms_condition"].stringValue
            txtData.text = htmltxt.htmlToString
        }
        

        // Do any additional setup after loading the view.
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
