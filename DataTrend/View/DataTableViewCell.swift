//
//  DataTableViewCell.swift
//  DataTrend
//
//  Created by Dinesh Reddy on 23/09/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var trendName: UILabel!
    @IBOutlet weak var trendValue: UILabel!
    @IBOutlet weak var trendThumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with resultObj: DisplayModel) {
        trendName?.text = resultObj.year
        trendValue?.text = resultObj.volume
    }
}
