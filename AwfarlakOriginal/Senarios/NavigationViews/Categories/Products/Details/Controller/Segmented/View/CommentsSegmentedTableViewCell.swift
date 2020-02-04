//
//  CommentsSegmentedTableViewCell.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/3/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class CommentsSegmentedTableViewCell: UITableViewCell {

    @IBOutlet weak var ownerCommentPhoto: UIImageView!{
        didSet{
            ownerCommentPhoto.layer.cornerRadius = ownerCommentPhoto.frame.size.height/2
            ownerCommentPhoto.clipsToBounds = true
        }
    }
    @IBOutlet weak var ownerCommentName: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
