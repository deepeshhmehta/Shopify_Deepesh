//
//  SpecialProvinceTableViewController.swift
//  Shopify_Deepesh
//
//  Created by Deepesh Mehta on 2018-07-20.
//  Copyright © 2018 Deepesh Mehta. All rights reserved.
//

import UIKit

class SpecialProvinceTableViewController: UITableViewController {

    @IBOutlet var specialProvinceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        specialProvinceTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.title = "Special By Province"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return DataShare.zoneWiseData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataShare.zoneWiseData[(DataShare.zoneData[section]["zone"] as? String)!]!.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let retString = (DataShare.zoneData[section]["zone"]! as? String)!
        return retString
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        //select current order object from orders to show
        let current : [String:Any] = DataShare.zoneWiseData[(DataShare.zoneData[indexPath.section]["zone"] as? String)!]![indexPath.row]
        
        //set data in cell
        
        cell.order_id.text = String(current["id"] as! Int)
        if let billing_address = current["billing_address"] as? [String: Any]{
            cell.cust_name.text = (billing_address)["name"] as? String
        }else{
            cell.cust_name.text = "Unknown"
        }
        cell.cust_email.text = current["email"] as? String
        
        return cell
    }
    

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        //instantiate a ListTableViewController (self defined)
//        let ListVC = storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
//        
//        //set up filter type and conditions in data share
//        DataShare.filterType = DataShare.ZONE_TYPE
//        DataShare.filterZone = DataShare.zoneData[indexPath.section]["zone"] as? String
//        
//        //call the instantiated ListTableViewController to apply the desired filters and load
//        navigationController?.pushViewController(ListVC, animated: true)
//    }

}
