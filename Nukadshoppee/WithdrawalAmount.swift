//
//  WithdrawalAmount.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 24/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

class WithdrawalAmount: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    

    @IBOutlet weak var AmountCollectionView: UICollectionView!
    @IBOutlet weak var lblClaimedAmount: UILabel!
    @IBOutlet weak var lblClaimedAmount2: UILabel!
    @IBOutlet weak var lblOtherAmount: UILabel!
    @IBOutlet weak var lblChargeAmount: UILabel!
    @IBOutlet weak var lblTaxAmount: UILabel!
    @IBOutlet weak var lblGetAmount: UILabel!
    
    //let amountArray = [100,200,300,400]
    //var Amtflag = [0,0,0,0]
    //let tax = 10.0
    //let charge = 3.0
    //let other = 5.0
    
    var amountArray:[Int] = [Int]()
    let tax = TaxData["tax"].floatValue
    let charge = TaxData["admin_charge"].floatValue
    let other = TaxData["other_charge"].floatValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AmountCollectionView.dataSource = self
        AmountCollectionView.delegate = self
        AmountCollectionView.allowsMultipleSelection = false
        
        
        loadData()
        
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return amountArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = AmountCollectionView.dequeueReusableCell(withReuseIdentifier: "amountCell", for: indexPath) as! AmountCell
        
        cell.lblAmount.text = String(amountArray[indexPath.row])
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let cell = AmountCollectionView.cellForItem(at: indexPath) as! AmountCell
        
        cell.lblAmount.backgroundColor = UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0)
        cell.lblAmount.textColor = UIColor.white
        
        //cell.lblAmount.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1.0)
        //cell.lblAmount.textColor = UIColor.black
        
        
        calculateAmount(index : indexPath.row)
 
 
 
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = AmountCollectionView.cellForItem(at: indexPath) as! AmountCell
        
        cell.lblAmount.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1.0)
        cell.lblAmount.textColor = UIColor.black
        
    }
    
    func calculateAmount(index : Int)
    {
        let amount = amountArray[index]
        let taxamount = Float(amount) * (tax/100.0)
        let chargeamount = Float(amount) * (charge/100.0)
        let otheramount = Float(amount) * (other/100.0)
        let getamount =  Float(amount) - (taxamount + chargeamount + otheramount)
        
        lblClaimedAmount2.text = String(amount)
        lblClaimedAmount.text = String(amount)
        lblTaxAmount.text = String(taxamount) + "(\(tax)%)"
        lblChargeAmount.text = String(chargeamount) + "(\(charge)%)"
        lblOtherAmount.text = String(otheramount) + "(\(other)%)"
        lblGetAmount.text = String(getamount)
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        if(lblClaimedAmount.text == "")
        {
           self.showAlert(title: "Select Chip", message: "Please Select any one chip from the above")
        }
        else
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let banksList = storyboard.instantiateViewController(withIdentifier: "banksList") as! BanksList
            banksList.taxAmount = (lblTaxAmount.text?.floatValue)!
            banksList.chargeAmount = (lblChargeAmount.text?.floatValue)!
            banksList.otherAmount = (lblOtherAmount.text?.floatValue)!
            banksList.payAmount = (lblGetAmount.text?.floatValue)!
            banksList.requestAmount = (lblClaimedAmount.text?.floatValue)!
            self.present(banksList, animated: true, completion: nil)
        }
        
    }
    
    func loadData()
    {
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        let GetPossibleAmountParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String ]
        
        Alamofire.request(PossibleAmountAPI, method: .post, parameters: GetPossibleAmountParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                let tempDict = JSON(response.result.value)
                
                if(tempDict["status"] == "success")
                {
                   print(tempDict["possible_withdrawal"][0])
                    
                    for i in 0...tempDict["possible_withdrawal"].count-1
                    {
                        self.amountArray.append(tempDict["possible_withdrawal"][i].intValue)
                    }
                    self.AmountCollectionView.reloadData()
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
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
