//
//  FAQTableViewCell.swift
//  Dr.Nour
//
//  Created by Mustafa on 12/20/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
protocol QuestionDelegate {
    func faqView( question: DesignableUITextField, answeer: UILabel )
}
class FAQTableViewCell: UITableViewCell {
    @IBOutlet weak var questionTf: DesignableUITextField!
    @IBOutlet weak var ansswerLbl: UILabel!
    
    var delegate: QuestionDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func questionClick(_ sender: UIButton) {
        delegate?.faqView(question: questionTf, answeer: ansswerLbl)
}
}

