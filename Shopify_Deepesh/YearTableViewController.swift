//
//  YearTableViewController.swift
//  Shopify_Deepesh
//
//  Created by Deepesh Mehta on 2018-05-09.
//  Copyright © 2018 Deepesh Mehta. All rights reserved.
//

import UIKit

class YearTableViewController: UITableViewController{
    //instance of year table
    @IBOutlet var yearTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register for generic cell
//        yearTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        yearTable.register(ListTableViewCell.self, forCellReuseIdentifier: "ListCell")
//        yearTable.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //rename navigation title
        navigationItem.title = "Orders By Year"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return DataShare.yearWiseData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return count from data source
        return DataShare.yearWiseData[(DataShare.yearData[section]["year"] as? String)!]!.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let retString = String(DataShare.yearData[section]["count"] as! Int) + " number of orders in " + (DataShare.yearData[section]["year"]! as? String)!
        return retString
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Generic cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell

        //select current order object from orders to show
        let current : [String:Any] = DataShare.yearWiseData[(DataShare.yearData[indexPath.section]["year"] as? String)!]![indexPath.row]

        //set data in cell

        cell.order_id.text = String(current["id"] as! Int)
        if let billing_address = current["billing_address"] as? [String: Any]{
            cell.cust_name.text = (billing_address)["name"] as? String
        }else{
            cell.cust_name.text = "Unknown"
        }
        cell.cust_email.text = current["email"] as? String
//        cell.textLabel?.text = "Hello"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //instantiate a ListTableViewController (self defined)
        let ListVC = storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
    
        //set up filter type and conditions in data share
        DataShare.filterType = DataShare.YEAR_TYPE
        DataShare.filterYear = DataShare.yearData[indexPath.section]["year"] as? String
        
        //call the instantiated ListTableViewController to apply the desired filters and load
        navigationController?.pushViewController(ListVC, animated: true)
    }

}
