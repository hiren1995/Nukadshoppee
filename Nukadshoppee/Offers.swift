//
//  Offers.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 18/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON
import Kingfisher

class Offers: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var lblNoOffers: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var ImgScrollView: UIScrollView!
    let count = 2
    //let imgArray = ["demo1","demo2"]
    
    var imgArray = ["demo1","demo2"]
    var imgURLArray = [String]()
    var tempDict = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        for i in 0...count-1
        {
            let imgView = UIImageView(frame: CGRect(x: self.ImgScrollView.frame.width * CGFloat(i), y: 0, width: self.ImgScrollView.frame.width, height: self.ImgScrollView.frame.height))
            imgView.image = UIImage(named: imgArray[i])
            
            ImgScrollView.addSubview(imgView)
        }
        
        self.ImgScrollView.contentSize = CGSize(width:self.ImgScrollView.frame.width * CGFloat(imgArray.count), height:self.ImgScrollView.frame.height)
        */
        
        lblNoOffers.isHidden = true
        self.ImgScrollView.delegate = self
 
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    @IBAction func btnPrevious(_ sender: UIButton) {
        
        if ( ImgScrollView.contentOffset.x <= ImgScrollView.contentSize.width )
        {
            var frame = CGRect()
            
            frame.origin.x = ImgScrollView.contentOffset.x - ImgScrollView.frame.size.width;
            frame.origin.y = 0;
            frame.size = ImgScrollView.frame.size;
            
            ImgScrollView.scrollRectToVisible(frame, animated: true)
            
        }
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        
        if ( ImgScrollView.contentOffset.x <= ImgScrollView.contentSize.width )
        {
            var frame = CGRect()
            
            frame.origin.x = ImgScrollView.contentOffset.x + ImgScrollView.frame.size.width;
            frame.origin.y = 0;
            frame.size = ImgScrollView.frame.size;
            
            ImgScrollView.scrollRectToVisible(frame, animated: true)
            
        }
        
    }
    
    func loadData()
    {
        let Spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        let GetOffersParameters:Parameters = ["app_user_id": udefault.value(forKey: UserId) as! Int , "app_user_token" : udefault.value(forKey: UserToken) as! String]
        
        Alamofire.request(GetDailyOffersAPI, method: .post, parameters: GetOffersParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            if(response.result.value != nil)
            {
                Spinner.hide(animated: true)
                
                print(JSON(response.result.value))
                
                self.tempDict = JSON(response.result.value)
                
                if(self.tempDict["status"] == "success")
                {
                    self.loadImages()
                }
                else
                {
                    self.showAlert(title: "NO OFFERS", message: "OOPS... No Daily Offers availible.We will update Offers Very soon.")
                    self.lblNoOffers.isHidden = false
                    self.btnNext.isHidden = true
                    self.btnPrevious.isHidden = true
                }
                
            }
            else
            {
                Spinner.hide(animated: true)
                self.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
            }
        })
    }

    func loadImages()
    {
        for i in 0...self.tempDict["get_daily_offers"].count - 1
        {
            let imgView = UIImageView(frame: CGRect(x: self.ImgScrollView.frame.width * CGFloat(i), y: 0, width: self.ImgScrollView.frame.width, height: self.ImgScrollView.frame.height))
            
            KingfisherManager.shared.downloader.downloadImage(with: NSURL(string: self.tempDict["get_daily_offers"][i]["daily_offer_pic"].stringValue)! as URL, retrieveImageTask: RetrieveImageTask.empty, options: [], progressBlock: nil, completionHandler: { (image,error, imageURL, imageData) in
                
                
                imgView.image = image
                
            })
            
            ImgScrollView.addSubview(imgView)
            
        }
        self.ImgScrollView.contentSize = CGSize(width:self.ImgScrollView.frame.width * CGFloat(self.tempDict["get_daily_offers"].count), height:self.ImgScrollView.frame.height)
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
