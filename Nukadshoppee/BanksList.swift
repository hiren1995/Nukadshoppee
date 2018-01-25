//
//  BanksList.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 25/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class BanksList: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    let names = ["ABC","XYZ","PQR"]
    let banks = ["Bank of India","Bank of Baroda","Bank of India"]
    let accounts = ["XXXXX1234","XXXXX1122","XXXXX1231"]
    
    @IBOutlet weak var BankTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BankTableView.dataSource = self
        BankTableView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = BankTableView.dequeueReusableCell(withIdentifier: "bankCell", for: indexPath) as! BankCell
        
        cell.cellView.addBorderShadow()
        cell.lblName.text = names[indexPath.row]
        cell.lblBankName.text = banks[indexPath.row]
        cell.lblAccountNumber.text = accounts[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
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
