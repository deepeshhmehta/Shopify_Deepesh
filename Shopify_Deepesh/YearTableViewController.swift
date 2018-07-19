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
        yearTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return count from data source
        return DataShare.yearData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Generic cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //Extract current data from datashare year data
        var current = DataShare.yearData[indexPath.row]
        
        //set value to be displayed
        let text = String(current["count"] as! Int) + " number of orders in " + (current["year"] as! String)
        cell.textLabel?.text = text

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //instantiate a ListTableViewController (self defined)
        let ListVC = storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
        
        //select the tapped data item
        var current = DataShare.yearData[indexPath.row]
        
        //set up filter type and conditions in data share
        DataShare.filterType = DataShare.YEAR_TYPE
        DataShare.filterYear = current["year"] as? String
        
        //call the instantiated ListTableViewController to apply the desired filters and load
        navigationController?.pushViewController(ListVC, animated: true)
    }

}
