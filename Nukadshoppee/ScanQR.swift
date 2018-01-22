//
//  ScanQR.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 18/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class ScanQR: UIViewController {

    
    @IBOutlet weak var lblAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rupee = "\u{20B9}"
        
        lblAmount.text = rupee + " 0"
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnScanQR(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let qrCodeScanningLogicView = storyboard.instantiateViewController(withIdentifier: "qrCodeScanningLogicView") as! QRCodeScanningLogicView
        self.present(qrCodeScanningLogicView, animated: true, completion: nil)
    }
    
    @IBAction func btnWallet(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let wallet = storyboard.instantiateViewController(withIdentifier: "wallet") as! Wallet
        self.present(wallet, animated: true, completion: nil)
        
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
