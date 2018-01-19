//
//  More.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 18/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class More: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let values = ["Promote your business with us","About us","Privacy policy","Terms & conditions","Contact us","Rate us","Logout"]
    let imgArray = ["business","about","privacy","term","contactus","rate","logout_more"]
    
    @IBOutlet weak var moreTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        moreTableView.delegate = self
        moreTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = moreTableView.dequeueReusableCell(withIdentifier: "moreCell", for: indexPath) as! MoreCell
        
        cell.lblName.text = values[indexPath.row]
        
        cell.imgView.image = UIImage(named: imgArray[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
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
