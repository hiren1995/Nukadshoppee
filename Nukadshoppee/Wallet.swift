//
//  Wallet.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class Wallet: UIViewController {

    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        balanceView.addBorderShadow()
        
        lblInfo.roundTopCorners(radius: 10)
        
        let rupee = "\u{20B9}"
        
        lblAmount.text = rupee + " 0"
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnTransactions(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let transactionsView = storyboard.instantiateViewController(withIdentifier: "transactionsView") as! TransactionsView
        self.present(transactionsView, animated: true, completion: nil)
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
