//
//  ClaimStatus.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 22/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class ClaimStatus: UIViewController {

    let approved:Bool = false
    
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var imgbg: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgOops: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rupee = "\u{20B9}"
        
        lblAmount.text = rupee + " 0"
        
        if approved
        {
            imgbg.image = UIImage(named: "bg_congo")
            txtMessage.text = "You got Rs." + "100" + "cash back (validity " + "2" + ").It will be credited to your account after approval of vendor."
            lblStatus.text = "Congratulations!!"
            imgOops.isHidden = true
        }
        else
        {
            imgbg.image = UIImage(named: "bg_oops")
            txtMessage.text = "Sorry your cash back claim has been rejected because you had already made 2 claims from same shopkeeper in last 30 days."
            
            lblStatus.text = "Oops!!!"
            imgOops.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnClose(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboard = storyboard.instantiateViewController(withIdentifier: "dashboard") as! Dashboard
        self.present(dashboard, animated: true, completion: nil)
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
