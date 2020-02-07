//
//  ContactUsViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/5/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
    
    var contactIcon = ["ContactPhone" , "Contactemail" , "Contacthome"]
    var contactTitle = ["contectPhone".localized , "contectEmail".localized , "contectAddress".localized]
    var contactData = ["01008182062 - 01024439000 - 01004646198" , "Info@aufarleky1.com" , "contectAddressDet".localized]


    @IBOutlet weak var contactUsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()

        // Do any additional setup after loading the view.
    }
    

}


extension ContactUsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactIcon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactUsTableViewCell", for: indexPath) as! ContactUsTableViewCell
        let cellIndex = indexPath.item
        cell.contactIcon.image = UIImage(named: contactIcon[cellIndex])
        cell.contactTitle.text = contactTitle[cellIndex]
        cell.contactData.text = contactData[cellIndex]
        
        return cell
    }
    
    
    
    //MARK:- didSelectRowAt
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
          
      }
    
    
    
}
