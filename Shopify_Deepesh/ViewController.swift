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
  
        let urlPath: String = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        let url: NSURL = NSURL(string: urlPath)!
        let request1: NSURLRequest = NSURLRequest(url: url as URL)
        let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
        
        
        do{
            
            let dataVal = try NSURLConnection.sendSynchronousRequest(request1 as URLRequest, returning: response)
            
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: dataVal, options: []) as? [String:Any]
                let orders = jsonResult!["orders"]
                
                //Variable to Store count in each zone
                var zoneCount : [String:Int] = [:]
                
                //Variable to store count in each year
                var yearCount : [String:Int] = [:]
                
                DataShare.orders_global = orders as? [[String:Any]]
                for order in DataShare.orders_global!{
                    
                    //Extracting zoneCountData
                    
                    extractZoneCountData(order:order,zoneCount: &zoneCount)
                    
                    //Extracting yearCountData
                    extractYearCountData(order:order,yearCount: &yearCount)
                    
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
                //remove the blank we added while initialisation
                zoneTableContent.removeFirst(1)
                
                //Dress Year Table Content for easy access by data source
                for year in sortedYear{
                    yearTableContent.append(["year":year.key, "count":year.value])
                }
                //remove the blank we added while initialisation
                yearTableContent.removeFirst(1)
                
                
                //Assign Content to Data Share
                DataShare.zoneData = zoneTableContent
                DataShare.yearData = yearTableContent
                
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //extract zone count data
    func extractZoneCountData(order: [String:Any], zoneCount: inout [String:Int]){
        guard let billing_details = order["billing_address"] as? [String:Any] else{return}
        if let province = billing_details["province"] as? String {
            if zoneCount[province] != nil{
                zoneCount[province] = zoneCount[province]! + 1
            }else{
                zoneCount[province] = 1
            }
        }else{return}
    }
    
    //extract year count data
    func extractYearCountData(order: [String:Any], yearCount: inout [String:Int]){
        if let date = order["created_at"] as? String {
            let year = date.substring(to: date.index(of: "-")!)
            if yearCount[year] != nil{
                yearCount[year] = yearCount[year]! + 1
            }else{
                yearCount[year] = 1
            }
        }else{return}
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
