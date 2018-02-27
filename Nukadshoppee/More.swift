//
//  More.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 18/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class More: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let values = ["Promote your business with us","About us","Privacy policy","Terms & conditions","Contact us","Rate us","Logout"]
    let imgArray = ["business","about","privacy","term","contactus","rate","logout_more"]
    
    @IBOutlet weak var lblUserNumber: UILabel!
    @IBOutlet weak var lblUserMailId: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var moreTableView: UITableView!
    @IBOutlet weak var imgProfilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moreTableView.delegate = self
        moreTableView.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = moreTableView.dequeueReusableCell(withIdentifier: "moreCell", for: indexPath) as! MoreCell
        
        cell.lblName.text = values[indexPath.row]
        
        cell.imgView.image = UIImage(named: imgArray[indexPath.row])
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let moreDetails = storyboard.instantiateViewController(withIdentifier: "moreDetails") as! MoreDetails
            moreDetails.strModule = "Promote"
            self.present(moreDetails, animated: true, completion: nil)
        }
        else if(indexPath.row == 1)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let moreDetails = storyboard.instantiateViewController(withIdentifier: "moreDetails") as! MoreDetails
            moreDetails.strModule = "About"
            self.present(moreDetails, animated: true, completion: nil)
        }
        else if(indexPath.row == 2)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let moreDetails = storyboard.instantiateViewController(withIdentifier: "moreDetails") as! MoreDetails
            moreDetails.strModule = "Privacy"
            self.present(moreDetails, animated: true, completion: nil)
        }
        else if(indexPath.row == 3)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let moreDetails = storyboard.instantiateViewController(withIdentifier: "moreDetails") as! MoreDetails
            moreDetails.strModule = "Terms"
            self.present(moreDetails, animated: true, completion: nil)
        }
        else if(indexPath.row == 4)
        {
            let email = "nukadshoppee@gmail.com"
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url)
            }
        }
        else if(indexPath.row == 5)
        {
            
        }
        else
        {
            
            let LogoutAlert = UIAlertController(title: "Logout", message: "Are You Sure You Want To Logout.", preferredStyle: UIAlertControllerStyle.alert)
            
            LogoutAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                
                udefault.removeObject(forKey: isLogin)
                udefault.removeObject(forKey: MobileNumber)
                udefault.removeObject(forKey: SignUpPassword)
                udefault.removeObject(forKey: isDetails)
                udefault.removeObject(forKey: UserId)
                udefault.removeObject(forKey: UserToken)
                udefault.removeObject(forKey: CityName)
                udefault.removeObject(forKey: CityId)
                udefault.removeObject(forKey: StateName)
                udefault.removeObject(forKey: StateId)
                udefault.removeObject(forKey: ReligionName)
                udefault.removeObject(forKey: ReligionID)
                udefault.removeObject(forKey: LoginMobile)
                udefault.removeObject(forKey: LoginPassword)
                udefault.removeObject(forKey: isEmailVerified)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let signIn = storyboard.instantiateViewController(withIdentifier: "signIn") as! SignIn
                self.present(signIn, animated: true, completion: nil)
                
            }))
            
            LogoutAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
                
                print("Logout Cancelled")
                
            }))
            
            present(LogoutAlert, animated: true, completion: nil)
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func btnUpdate2(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let updateProfile = storyboard.instantiateViewController(withIdentifier: "updateProfile") as! UpdateProfile
        self.present(updateProfile, animated: true, completion: nil)
        
    }
    @IBAction func btnUpdate(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let updateProfile = storyboard.instantiateViewController(withIdentifier: "updateProfile") as! UpdateProfile
        self.present(updateProfile, animated: true, completion: nil)
        
    }
    
    func loadData()
    {
        lblUserName.text = UserData["app_user_name"].stringValue
        lblUserMailId.text = UserData["app_user_email"].stringValue
        lblUserNumber.text = UserData["app_user_contact_number"].stringValue
        
        if(UserData["app_user_profilepic"].stringValue != "")
        {
            KingfisherManager.shared.downloader.downloadImage(with: NSURL(string: UserData["app_user_profilepic"].stringValue)! as URL, retrieveImageTask: RetrieveImageTask.empty, options: [], progressBlock: nil, completionHandler: { (image,error, imageURL, imageData) in
                
                
                self.imgProfilePic.image = image
                
            })
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
