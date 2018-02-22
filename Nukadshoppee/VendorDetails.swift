//
//  VendorDetails.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 23/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import AARatingBar
import Alamofire
import MBProgressHUD
import Kingfisher
import SwiftyJSON

class VendorDetails: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var lblVendorName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblArea: UILabel!
    @IBOutlet weak var lblShopOpening: UILabel!
    @IBOutlet weak var lblShopClosing: UILabel!
    @IBOutlet weak var lblDealsIn: UILabel!
    @IBOutlet weak var ratingBar: AARatingBar!
    @IBOutlet weak var ImgScrollView: UIScrollView!
    let count = 2
    let imgArray = ["demo1","demo2"]
    
    var tempDict = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ratingBar.value = CGFloat(2.5)
        /*
        for i in 0...count-1
        {
            let imgView = UIImageView(frame: CGRect(x: self.ImgScrollView.frame.width * CGFloat(i), y: 0, width: self.ImgScrollView.frame.width, height: self.ImgScrollView.frame.height))
            imgView.image = UIImage(named: imgArray[i])
            
            ImgScrollView.addSubview(imgView)
        }
        
        self.ImgScrollView.contentSize = CGSize(width:self.ImgScrollView.frame.width * CGFloat(imgArray.count), height:self.ImgScrollView.frame.height)
        */
        
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
    
    @IBAction func btnMap(_ sender: UIButton) {
        
        let lat = tempDict["shop_latitude"].floatValue
        let lon = tempDict["shop_longitude"].floatValue
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"https://maps.google.com")! as URL))
        {
            UIApplication.shared.openURL(NSURL(string:
                "https://maps.google.com/?q=@\(lat),\(lon)")! as URL)
        }
        
    }
    
    @IBAction func btnPhone(_ sender: UIButton) {
        
        let num = tempDict["owner_contactno"].intValue
        
        if let url = URL(string: "tel://\(num)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
   
    func loadData()
    {
            print(tempDict)
        
            lblVendorName.text = tempDict["shop_name"].stringValue
            ratingBar.value = CGFloat(tempDict["0"].floatValue)
            lblCategory.text = tempDict["cate_name"].stringValue
            lblDealsIn.text = tempDict["deals_in"].stringValue
        
            setTimes()
        
        if(tempDict["banner_list"].count != 0)
        {
            loadImages()
        }
        
    }
    func loadImages()
    {
        print(self.tempDict["banner_list"].count)
        
        for i in 0...self.tempDict["banner_list"].count - 1
        {
            let imgView = UIImageView(frame: CGRect(x: self.ImgScrollView.frame.width * CGFloat(i), y: 0, width: self.ImgScrollView.frame.width, height: self.ImgScrollView.frame.height))
            
            KingfisherManager.shared.downloader.downloadImage(with: NSURL(string: self.tempDict["banner_list"][i]["shop_banner_images"].stringValue)! as URL, retrieveImageTask: RetrieveImageTask.empty, options: [], progressBlock: nil, completionHandler: { (image,error, imageURL, imageData) in
                
                imgView.image = image
                //imgView.tag = i
                
                imgView.isUserInteractionEnabled = true
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imgTapped(sender:)))
                tapGesture.view?.tag = i
                
                imgView.addGestureRecognizer(tapGesture)
            })
            
            ImgScrollView.addSubview(imgView)
            
        }
        self.ImgScrollView.contentSize = CGSize(width:self.ImgScrollView.frame.width * CGFloat(self.tempDict["banner_list"].count), height:self.ImgScrollView.frame.height)
    }
    
    func setTimes()
    {
        
        let dict = convertToDictionary(text: tempDict["working_hours"].stringValue)
        var workingHours = dict!["week_days"]  as! [[String:Any]]
        print(workingHours[0])
        
        let Today = Date()
        
        let dayInt = getDayOfWeek(today: Today)
        
        print(dayInt)
        
        if(dayInt == 2)
        {
            if(workingHours[0]["is_open"] as? String == "true")
            {
                lblShopOpening.text = timeFormatter(date : (workingHours[0]["opening_hours"] as? String)!)
                lblShopClosing.text = timeFormatter(date : (workingHours[0]["closing_hours"] as? String)!)
            }
            else
            {
                lblShopOpening.text = "Closed Today"
                lblShopClosing.text = "Closed Today"
            }
        }
        else if(dayInt == 3)
        {
            if(workingHours[1]["is_open"] as? String == "true")
            {
                lblShopOpening.text = timeFormatter(date : (workingHours[1]["opening_hours"] as? String)!)
                lblShopClosing.text = timeFormatter(date : (workingHours[1]["closing_hours"] as? String)!)
               
            }
            else
            {
                lblShopOpening.text = "Closed Today"
                lblShopClosing.text = "Closed Today"
            }
            
        }
        else if(dayInt == 4)
        {
            if(workingHours[2]["is_open"] as? String == "true")
            {
                lblShopOpening.text = timeFormatter(date : (workingHours[2]["opening_hours"] as? String)!)
                lblShopClosing.text = timeFormatter(date : (workingHours[2]["closing_hours"] as? String)!)
                
            }
            else
            {
                lblShopOpening.text = "Closed Today"
                lblShopClosing.text = "Closed Today"
            }
            
        }
        else if(dayInt == 5)
        {
            if(workingHours[3]["is_open"] as? String == "true")
            {
                lblShopOpening.text = timeFormatter(date : (workingHours[3]["opening_hours"] as? String)!)
                lblShopClosing.text = timeFormatter(date : (workingHours[3]["closing_hours"] as? String)!)
                
            }
            else
            {
                lblShopOpening.text = "Closed Today"
                lblShopClosing.text = "Closed Today"
            }
            
        }
        else if(dayInt == 6)
        {
            
            if(workingHours[4]["is_open"] as? String == "true")
            {
                lblShopOpening.text = timeFormatter(date : (workingHours[4]["opening_hours"] as? String)!)
                lblShopClosing.text = timeFormatter(date : (workingHours[4]["closing_hours"] as? String)!)
                
            }
            else
            {
                lblShopOpening.text = "Closed Today"
                lblShopClosing.text = "Closed Today"
            }
            
        }
        else if(dayInt == 7)
        {
            if(workingHours[5]["is_open"] as? String == "true")
            {
                lblShopOpening.text = timeFormatter(date : (workingHours[5]["opening_hours"] as? String)!)
                lblShopClosing.text = timeFormatter(date : (workingHours[5]["closing_hours"] as? String)!)
                
            }
            else
            {
                lblShopOpening.text = "Closed Today"
                lblShopClosing.text = "Closed Today"
            }
            
        }
        else
        {
            if(workingHours[6]["is_open"] as? String == "true")
            {
                lblShopOpening.text = timeFormatter(date : (workingHours[6]["opening_hours"] as? String)!)
                lblShopClosing.text = timeFormatter(date : (workingHours[6]["closing_hours"] as? String)!)
            }
            else
            {
                lblShopOpening.text = "Closed Today"
                lblShopClosing.text = "Closed Today"
            }
            
        }
       
    }
    
    @objc func imgTapped(sender : UITapGestureRecognizer)
    {
        print(sender.view?.tag)
        
        if(self.tempDict["banner_list"][(sender.view?.tag)!]["redirect_url"] != JSON.null)
        {
            guard let url = URL(string: self.tempDict["banner_list"][(sender.view?.tag)!]["redirect_url"].stringValue) else {
                return //be safe
            }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
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
