//
//  WorkingHoursTableViewCell.swift
//  Asurion-iOS-Demo
//
//  Created by Tyler Wells on 8/24/20.
//  Copyright © 2020 Tyler Wells. All rights reserved.
//

import UIKit

class WorkingHoursTableViewCell: UITableViewCell {

    @IBOutlet weak var LabelContainerView: UIView!
    @IBOutlet weak var officeHoursLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        LabelContainerView.layer.borderWidth = 2
        LabelContainerView.layer.borderColor = UIColor.lightGray.cgColor
    }
}
