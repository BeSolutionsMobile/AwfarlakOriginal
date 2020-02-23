//
//  FAQTableViewCell.swift
//  Dr.Nour
//
//  Created by Mustafa on 12/20/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

//MARK: - Insert New Protocal QuestionDelegate

protocol QuestionDelegate {
    func faqView( question: DesignableUITextField, answeer: UILabel  , text:String)
}

class FAQTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet

    @IBOutlet weak var questionTf: DesignableUITextField!
    @IBOutlet weak var ansswerLbl: UILabel!
    
    //MARK: - Variables

    var delegate: QuestionDelegate?
    var answer: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - IBAction

    @IBAction func questionClick(_ sender: UIButton) {
        if let answer = answer {
            delegate?.faqView(question: questionTf, answeer: ansswerLbl, text: answer)

        }
}
}

