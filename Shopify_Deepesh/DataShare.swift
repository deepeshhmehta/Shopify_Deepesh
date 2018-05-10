//
//  DataShare.swift
//  Shopify_Deepesh
//
//  Created by Deepesh Mehta on 2018-05-10.
//  Copyright © 2018 Deepesh Mehta. All rights reserved.
//

import UIKit

class DataShare: NSObject {
    static var zoneType : Int = 1
    static var yearType : Int = 2
    static var orders_global : [[String:Any]]?
    static var yearData : [[String:Any]]  = [["count" : 0,"year" : "Test"]]
    static var zoneData : [[String:Any]] = [["zone":"Test","count": 0]]
    static var filterType : Int = DataShare.zoneType // 1 = Zone; 2 = Year
    static var filterZone : String?
    static var filterYear : String?
    static var orders_to_show : [[String:Any]]?
}
