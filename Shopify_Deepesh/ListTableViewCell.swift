//
//  ListTableViewCell.swift
//  Shopify_Deepesh
//
//  Created by Deepesh Mehta on 2018-05-10.
//  Copyright © 2018 Deepesh Mehta. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    //instances of labels
    @IBOutlet weak var order_id: UILabel!
    @IBOutlet weak var cust_name: UILabel!
    @IBOutlet weak var cust_email: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
