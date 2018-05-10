//
//  ListTableViewController.swift
//  Shopify_Deepesh
//
//  Created by Deepesh Mehta on 2018-05-10.
//  Copyright © 2018 Deepesh Mehta. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    @IBOutlet var list_table: UITableView!
    
    override func viewDidLoad() {
        list_table.register(ListTableViewCell.self, forCellReuseIdentifier: "ListCell")
        
        super.viewDidLoad()
        if(DataShare.filterType == DataShare.zoneType){
            filterByZone()
        }else if(DataShare.filterType == DataShare.yearType){
            filterByYear()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (DataShare.orders_to_show?.count)!
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        let current = DataShare.orders_to_show![indexPath.row]
        cell.order_id.text = String(current["id"] as! Int)
        if let billing_address = current["billing_address"] as? [String: Any]{
            cell.cust_name.text = (billing_address)["name"] as? String
        }else{
            cell.cust_name.text = "Unknown"
        }
        
        cell.cust_email.text = current["email"] as? String

        return cell
    }
    
    
    func filterByZone(){
        self.navigationItem.title = DataShare.filterZone
        DataShare.orders_to_show = [[:]]
        for order in DataShare.orders_global!{
            guard let billing_details = order["billing_address"] as? [String:Any] else{continue}
            if(billing_details["province"] as? String == DataShare.filterZone){
                DataShare.orders_to_show?.append(order)
            }
        }
        DataShare.orders_to_show?.removeFirst(1)
    }
    
    func filterByYear(){
        self.navigationItem.title = DataShare.filterYear
        DataShare.orders_to_show = [[:]]
        for order in DataShare.orders_global!{
            let date = order["created_at"] as! String
            let year = date.substring(to: date.index(of: "-")!)
            if( year == DataShare.filterYear){
                DataShare.orders_to_show?.append(order)
            }
        }
        DataShare.orders_to_show?.removeFirst(1)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
