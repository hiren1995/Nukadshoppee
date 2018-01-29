//
//  UpdateProfile.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 23/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

var UpdatedGender:String = "Male"

class UpdateProfile: UIViewController {
    
    @IBOutlet weak var imgMale: UIImageView!
    @IBOutlet weak var imgFemale: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        imgFemale.image = nil
        imgFemale.backgroundColor = UIColor.white
        imgFemale.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnMaleClicked(_ sender: Any) {
        MaleRadioButton()
    }
    
    
    @IBAction func btnFemaleClicked(_ sender: Any) {
        FemaleRadioButton()
    }
    
    func MaleRadioButton()
    {
        imgMale.image = UIImage(named: "radio-on")
        imgMale.removeImageborder()
        Gender = "Male"
        imgFemale.image = nil
        imgFemale.backgroundColor = UIColor.white
        imgFemale.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
    }
    func FemaleRadioButton()
    {
        imgFemale.image = UIImage(named: "radio-on")
        imgFemale.removeImageborder()
        Gender = "Female"
        imgMale.image = nil
        imgMale.backgroundColor = UIColor.white
        imgMale.setImageborder(colorValue: UIColor(red: 34/255, green: 48/255, blue: 144/255, alpha: 1.0), widthValue: 1.0, cornerRadiusValue: 10.0)
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
