//
//  ListTableViewController.swift
//  Shopify_Deepesh
//
//  Created by Deepesh Mehta on 2018-05-10.
//  Copyright © 2018 Deepesh Mehta. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    //Instance of the list table
    @IBOutlet var list_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register to custom cell
        list_table.register(ListTableViewCell.self, forCellReuseIdentifier: "ListCell")
        
        //flush down previous results
        DataShare.orders_to_show = [[:]]

        //check for which type of filter is applied and fill data
        if(DataShare.filterType == DataShare.ZONE_TYPE){
            filterByZone()
        }else if(DataShare.filterType == DataShare.YEAR_TYPE){
            filterByYear()
        }
        
        //remove blank entry
        DataShare.orders_to_show?.removeFirst(1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (DataShare.orders_to_show?.count)!
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        //creating instance of self defined cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        //select current order object from orders to show
        let current = DataShare.orders_to_show![indexPath.row]
        
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
    
    //filter orders to be shown according to zone parameters updated in datashare
    func filterByZone(){
        //change title to zone name
        self.navigationItem.title = DataShare.filterZone
        
        //set up new results by correct zone filter
        for order in DataShare.orders_global!{
            guard let billing_details = order["billing_address"] as? [String:Any] else{continue}
            if(billing_details["province"] as? String == DataShare.filterZone){
                DataShare.orders_to_show?.append(order)
            }
        }
    }
    
    //filter orders to be shown according to year parameters updated in datashare
    func filterByYear(){
        
        //change title to year
        self.navigationItem.title = DataShare.filterYear
        
        //set up new results by correct year filter
        for order in DataShare.orders_global!{
            let date = order["created_at"] as! String
            let year = date.substring(to: date.index(of: "-")!)
            if( year == DataShare.filterYear){
                DataShare.orders_to_show?.append(order)
            }
        }
    }

}
