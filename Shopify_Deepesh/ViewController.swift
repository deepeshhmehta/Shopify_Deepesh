//
//  ViewController.swift
//  Shopify_Deepesh
//
//  Created by Deepesh Mehta on 2018-05-09.
//  Copyright © 2018 Deepesh Mehta. All rights reserved.
//

import UIKit


class ViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
  
        //Set up variables for API call
        let urlPath: String = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        let url: NSURL = NSURL(string: urlPath)!
        let request1: NSURLRequest = NSURLRequest(url: url as URL)
        let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
        
        
        do{
            //send request and capture results
            let dataVal = try NSURLConnection.sendSynchronousRequest(request1 as URLRequest, returning: response)
            
            do {
                //parse results as JSON
                let jsonResult = try JSONSerialization.jsonObject(with: dataVal, options: []) as? [String:Any]
                
                //extract what is needed in global orders
                DataShare.orders_global = jsonResult!["orders"] as? [[String:Any]]
                
                //Variable to Store count in each zone
                var zoneCount : [String:Int] = [:]
                
                //Variable to store count in each year
                var yearCount : [String:Int] = [:]
                var yearWiseData : [String:[[String:Any]]] = [:]
                
                
                for order in DataShare.orders_global!{
                    
                    //Extracting zoneCountData
                    extractZoneCountData(order:order,zoneCount: &zoneCount)
                    
                    //Extracting yearCountData
                    extractYearCountData(order:order,yearCount: &yearCount, yearWiseData: &yearWiseData)
                    
                }
                
                // Sort zone & year data alphabetically
                let sortedZone = zoneCount.sorted(by:<)
                let sortedYear = yearCount.sorted(by:>)
                
                //initialise data to be sent to respective data sources
                var zoneTableContent : [[String:Any]] = [[:]]
                var yearTableContent : [[String:Any]] = [[:]]
                
                //Dress Zone Table Content for easy access by data source
                for zone in sortedZone{
                    zoneTableContent.append(["zone":zone.key, "count":zone.value])
                }
                
                //Dress Year Table Content for easy access by data source
                for year in sortedYear{
                    yearTableContent.append(["year":year.key, "count":year.value])
                }
                
                //remove the blanks we added while initialisation
                zoneTableContent.removeFirst(1)
                yearTableContent.removeFirst(1)
                
                for yearData in yearWiseData {
                    yearWiseData[yearData.key]?.removeFirst(1)
                }
                
                
                //Assign Content to Data Share (Data Sources pick data from data share)
                DataShare.zoneData = zoneTableContent
                DataShare.yearData = yearTableContent
                DataShare.yearWiseData = yearWiseData
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //extract zone count data and update variable using parameter by reference
    func extractZoneCountData(order: [String:Any], zoneCount: inout [String:Int]){
        //check if billing_details field exists
        guard let billing_details = order["billing_address"] as? [String:Any] else{return}
        
        //check if province exists
        if let province = billing_details["province"] as? String {
            //if zone already exists in count increment else create
            if zoneCount[province] != nil{
                zoneCount[province] = zoneCount[province]! + 1
            }else{
                zoneCount[province] = 1
            }
        }else{return}
    }
    
    //extract year count data and update variable using parameter by reference
    func extractYearCountData(order: [String:Any], yearCount: inout [String:Int], yearWiseData: inout [String:[[String:Any]]]){
        //check if created_at exists
        if let date = order["created_at"] as? String {
            //extract year from string date
            let year = date.substring(to: date.index(of: "-")!)
            
            //if year already exists in count increment else create
            if yearCount[year] != nil{
                yearCount[year] = yearCount[year]! + 1
            }else{
                yearCount[year] = 1
                yearWiseData[year] = [[:]]
            }
            if ((yearWiseData[year]?.count)! < 11){
                yearWiseData[year]?.append(order)
            }
        }else{return}
    }

}
