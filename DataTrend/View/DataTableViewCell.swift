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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        trendThumbnail.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with resultObj: DisplayModel) {
        trendName?.text = resultObj.year
        trendValue?.text = resultObj.volume
        trendThumbnail.isHidden = !resultObj.isUsageDecreased
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        Utility.showErrorAlert(with: "Notices usage decline in quarter")
    }
}
