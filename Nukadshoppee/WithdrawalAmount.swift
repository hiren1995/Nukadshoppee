//
//  WithdrawalAmount.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 24/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class WithdrawalAmount: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    

    @IBOutlet weak var AmountCollectionView: UICollectionView!
    @IBOutlet weak var lblClaimedAmount: UILabel!
    @IBOutlet weak var lblClaimedAmount2: UILabel!
    @IBOutlet weak var lblOtherAmount: UILabel!
    @IBOutlet weak var lblChargeAmount: UILabel!
    @IBOutlet weak var lblTaxAmount: UILabel!
    @IBOutlet weak var lblGetAmount: UILabel!
    
    let amountArray = [100,200,300,400]
    var Amtflag = [0,0,0,0]
    let tax = 10.0
    let charge = 3.0
    let other = 5.0
    
   
    var highlightcell:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AmountCollectionView.dataSource = self
        AmountCollectionView.delegate = self
        AmountCollectionView.allowsMultipleSelection = false
        
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
        let taxamount = Double(amount) * (tax/100.0)
        let chargeamount = Double(amount) * (charge/100.0)
        let otheramount = Double(amount) * (other/100.0)
        let getamount =  Double(amount) - (taxamount + chargeamount + otheramount)
        
        lblClaimedAmount2.text = String(amount)
        lblClaimedAmount.text = String(amount)
        lblTaxAmount.text = String(taxamount) + "(\(tax)%)"
        lblChargeAmount.text = String(chargeamount) + "(\(charge)%)"
        lblOtherAmount.text = String(otheramount) + "(\(other)%)"
        lblGetAmount.text = String(getamount)
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
