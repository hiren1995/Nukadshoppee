//
//  Offers.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 18/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class Offers: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var ImgScrollView: UIScrollView!
    let count = 2
    let imgArray = ["demo1","demo2"]
    //let imgViewArray:UIImageView = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...count-1
        {
            let imgView = UIImageView(frame: CGRect(x: self.ImgScrollView.frame.width * CGFloat(i), y: 0, width: self.ImgScrollView.frame.width, height: self.ImgScrollView.frame.height))
            imgView.image = UIImage(named: imgArray[i])
            
            ImgScrollView.addSubview(imgView)
        }
        
        self.ImgScrollView.contentSize = CGSize(width:self.ImgScrollView.frame.width * 4, height:self.ImgScrollView.frame.height)
        
        self.ImgScrollView.delegate = self
        
        // Do any additional setup after loading the view.
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
