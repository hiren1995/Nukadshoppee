//
//  VendorDetails.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 23/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import AARatingBar

class VendorDetails: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var ratingBar: AARatingBar!
    @IBOutlet weak var ImgScrollView: UIScrollView!
    let count = 2
    let imgArray = ["demo1","demo2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingBar.value = CGFloat(2.5)
        
        for i in 0...count-1
        {
            let imgView = UIImageView(frame: CGRect(x: self.ImgScrollView.frame.width * CGFloat(i), y: 0, width: self.ImgScrollView.frame.width, height: self.ImgScrollView.frame.height))
            imgView.image = UIImage(named: imgArray[i])
            
            ImgScrollView.addSubview(imgView)
        }
        
        self.ImgScrollView.contentSize = CGSize(width:self.ImgScrollView.frame.width * CGFloat(imgArray.count), height:self.ImgScrollView.frame.height)
        
        self.ImgScrollView.delegate = self

        // Do any additional setup after loading the view.
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
        
        let lat = 22.32
        let lon = 73.10
        if (UIApplication.shared.canOpenURL(NSURL(string:"https://maps.google.com")! as URL))
        {
            UIApplication.shared.openURL(NSURL(string:
                "https://maps.google.com/?q=@\(lat),\(lon)")! as URL)
        }
        
    }
    
    @IBAction func btnPhone(_ sender: UIButton) {
        
        let num = 9638145530
        
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
