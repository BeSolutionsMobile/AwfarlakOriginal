//
//  ContactUsTableViewCell.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/5/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class ContactUsTableViewCell: UITableViewCell {

    @IBOutlet weak var contactIcon: UIImageView!
    @IBOutlet weak var contactTitle: UILabel!
    @IBOutlet weak var contactData: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
