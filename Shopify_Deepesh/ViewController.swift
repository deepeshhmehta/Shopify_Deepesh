//
//  ViewController.swift
//  Shopify_Deepesh
//
//  Created by Deepesh Mehta on 2018-05-09.
//  Copyright © 2018 Deepesh Mehta. All rights reserved.
//

import UIKit


class ViewController: UITabBarController {
    var data : Int = 2
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let urlPath: String = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        let url: NSURL = NSURL(string: urlPath)!
        let request1: NSURLRequest = NSURLRequest(url: url as URL)
        let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
        
        
        do{
            
            let dataVal = try NSURLConnection.sendSynchronousRequest(request1 as URLRequest, returning: response)
            
            print(response)
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: dataVal, options: []) as? NSDictionary {
                    print("Synchronous\(jsonResult)")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
            
        }catch let error as NSError
        {
            print(error.localizedDescription)
        }
/*
        Alamofire.request("https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
            .responseJSON { (responseData) -> Void in
                guard let responseJSON = responseData.result.value as? [String: Any],
                    let results = responseJSON["data"] as? [[String: Any]]
                    else {
                        return
                }
*/
        // Do any additional setup after loading the view.
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
