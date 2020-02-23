//
//  FAQViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/5/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {
    
    //MARK: - Variables
    
    var faQuestion : FaQuestion?
    
    //MARK: - IBOutlet
    let titlesF = ["￼What 3rd-party-applications","What","What","What"]
    @IBOutlet weak var faqTableView: UITableView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        getAllQuestion()
        
        faqTableView.register(UINib(nibName: "FAQTableViewCell", bundle: nil), forCellReuseIdentifier: "FAQTableViewCell")
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Func to Get All Question
    
    func getAllQuestion()  {
        Services.getQuestion(callback: { (result) in
            print(result)
            switch result.status {
            case 1:
                self.faQuestion = result
                self.faqTableView.reloadData()
            case 2:
                Alert.show("Error".localized, massege: result.message!, context: self)
            default:
                print(result.status)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
}

//MARK: - Extension

//MARK:-UITableViewDataSource And UITableViewDelegate

extension FAQViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  faQuestion?.questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell", for: indexPath) as! FAQTableViewCell
        cell.questionTf.text = faQuestion?.questions?[indexPath.item].title
        cell.answer = faQuestion?.questions?[indexPath.item].questionDescription
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = Bundle.main.loadNibNamed("TitleOfSectionTableViewCell", owner: self, options: nil)?.first as! TitleOfSectionTableViewCell
        sectionHeader.groupName.text = "Group".localized  +  String(section+1)
        return sectionHeader
    }
}

//MARK:- DropDown Delegate
extension FAQViewController: QuestionDelegate {
    func faqView(question: DesignableUITextField, answeer: UILabel, text: String) {
        if answeer.text == "" {
            question.rightImage = #imageLiteral(resourceName: "faqMinus")
            answeer.text = text
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        } else {
            question.rightImage = #imageLiteral(resourceName: "faqPlus")
            answeer.text = ""
        }
        
        faqTableView.estimatedRowHeight = 60
        faqTableView.rowHeight = UITableView.automaticDimension
        faqTableView.reloadData()
    }
    
    
}




