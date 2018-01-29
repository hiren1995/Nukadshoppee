//
//  BankDetails.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 27/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

var AccountType:String = "Saving"

class BankDetails: UIViewController {

    @IBOutlet weak var imgSaving: UIImageView!
    @IBOutlet weak var imgCurrent: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        imgCurrent.image = nil
        imgCurrent.backgroundColor = UIColor.white
        imgCurrent.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSavingClicked(_ sender: Any) {
        SavingRadioButton()
    }
    
    
    @IBAction func btnCurrentClicked(_ sender: Any) {
        CurrentRadioButton()
    }
    
    func SavingRadioButton()
    {
        imgSaving.image = UIImage(named: "radio-on")
        imgSaving.removeImageborder()
        AccountType = "Saving"
        imgCurrent.image = nil
        imgCurrent.backgroundColor = UIColor.white
        imgCurrent.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
    }
    func CurrentRadioButton()
    {
        imgCurrent.image = UIImage(named: "radio-on")
        imgCurrent.removeImageborder()
        AccountType = "Current"
        imgSaving.image = nil
        imgSaving.backgroundColor = UIColor.white
        imgSaving.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
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
