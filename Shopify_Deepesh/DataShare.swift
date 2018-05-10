//
//  DataShare.swift
//  Shopify_Deepesh
//
//  Created by Deepesh Mehta on 2018-05-10.
//  Copyright © 2018 Deepesh Mehta. All rights reserved.
//

//Created as a uniform location to share data between controllers

import UIKit

class DataShare: NSObject {
    //to be used as constants
    static let ZONE_TYPE : Int = 1
    static let YEAR_TYPE : Int = 2
    
    //storing all the orders received from the API
    static var orders_global : [[String:Any]]?
    
    //data to be used to load the year-wise table
    static var yearData : [[String:Any]]  = [["count" : 0,"year" : "Test"]]
    
    //data to be used to load the zone-wise table
    static var zoneData : [[String:Any]] = [["zone":"Test","count": 0]]
    
    //decide what data to load in the list table
    static var filterType : Int = DataShare.ZONE_TYPE // 1 = Zone; 2 = Year
    
    //filter criterias
    static var filterZone : String?
    static var filterYear : String?
    
    //orders to show in the list table
    static var orders_to_show : [[String:Any]]?
}
