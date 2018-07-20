//
//  ZoneTableViewController.swift
//  Shopify_Deepesh
//
//  Created by Deepesh Mehta on 2018-05-09.
//  Copyright © 2018 Deepesh Mehta. All rights reserved.
//

import UIKit

class ZoneTableViewController: UITableViewController {
    //instance of zoneTable
    @IBOutlet var zoneTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register for generic cell
        zoneTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //set navigation title
        navigationItem.title = "Orders By Province"
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(self.navBarTapped(_:)))
        
        self.navigationController?.navigationBar.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func navBarTapped(_ theObject: AnyObject){
        let SpecialVC = storyboard?.instantiateViewController(withIdentifier: "SpecialViewController") as! ListTableViewController
        navigationController?.pushViewController(SpecialVC, animated: true)
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
        //return number of rows in zoneData of data share
        return DataShare.zoneData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //generic cell instantiated
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //extract current data object from zonedata
        var current = DataShare.zoneData[indexPath.row]
        
        //set value to be displayed in cell
        let text = String((current["count"] as? Int)!) + " number of orders from " + (current["zone"] as? String)!
        cell.textLabel?.text = text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //instantiate ListTableViewController (self defined)
        let ListVC = storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
        
        //select the tapped data item
        var current = DataShare.zoneData[indexPath.row]
        
        //set up filter type and conditions in data share
        DataShare.filterType = DataShare.ZONE_TYPE
        DataShare.filterZone = current["zone"] as? String
        
        //remove tap recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(self.navBarTapped(_:)))
        navigationController?.navigationBar.removeGestureRecognizer(tapGestureRecognizer)
        
        //call the instantiated ListTableViewController to apply the desired filters and load
        navigationController?.pushViewController(ListVC, animated: true)
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
