//
//  CommentsSegmentedViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/3/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class CommentsSegmentedViewController: UIViewController  {
    
    //MARK: - Variables
    
    var productComments : ProductComments?
    var addComments : AddComments?
    
    var kyHeight:CGFloat?
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var writeeCommentTf: UITextField!{
        didSet{
            writeeCommentTf.delegate = self
            
        }
    }
    @IBOutlet weak var sendCommentBtn: UIButton!
    @IBOutlet weak var viewWriteCommentBottom: NSLayoutConstraint!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductComment()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        commentTableView.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK: - Func to Calculation KeyBoard Height
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            kyHeight = keyboardHeight
            if let kH = self.kyHeight {
                self.viewWriteCommentBottom.constant = kH - 80
                print(kH)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    //MARK: - Func to Dismiss KeyBoard 
    
    @objc func tableViewTapped()  {
        writeeCommentTf.endEditing(true)
    }
    
    
    
    //MARK: - Func to Get Product Comment
    
    func getProductComment()  {
        if let idProduct = ProductDetailsViewController.idProduct {
            Services.getComments(idProduct: idProduct, pageNumber: 1, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.productComments = result
                    self.commentTableView.reloadData()
                case 2:
                    Alert.show("", massege: result.message!, context: self)
                case 3:
                    Alert.show("Error".localized, massege: "Comments".localized, context: self)
                default:
                    print(result.status)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Func to Add Comments
       
       func addComment()  {
         if let idProduct = ProductDetailsViewController.idProduct {
            Services.addComments(comment: "zsxdcfgvbhnj", idProduct: idProduct, idUser: UserDefault.getId(), callback: { (result) in
                   print(result)
                   switch result.status {
                   case 1:
                       self.addComments = result
                       Alert.show("Success".localized, massege: result.message, context: self)
                       self.clearText()
                       self.getProductComment()
                    case 2:
                        Alert.show("Error".localized, massege: result.message, context: self)
                   default:
                       print(result.status)
                   }
               }) { (error) in
                   print(error.localizedDescription)
               }
        }
           
       }
    
    //MARK: - Func to Empty TextFaild
       
       func clearText()  {
           writeeCommentTf.text = ""
       }
    
    //TODO: Declare textFieldDidBeginEditing here:
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(self.keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
        }
        
    }
    
    
    //TODO: Declare textFieldDidEndEditing here:
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.viewWriteCommentBottom.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    //MARK: - IBAction
    
    @IBAction func sendCommentBtnPressed(_ sender: UIButton) {
        addComment()
    }
    
    
}

//MARK: - Extension

//MARK:-UITableViewDataSource And UITableViewDelegate

extension CommentsSegmentedViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  productComments?.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsSegmentedTableViewCell", for: indexPath) as! CommentsSegmentedTableViewCell
        let cellIndex = indexPath.row
        cell.ownerCommentPhoto.sd_setImage(with: URL(string: productComments?.comments?[cellIndex].userPhoto ?? ""), placeholderImage: UIImage(named: "person1"))
        cell.ownerCommentName.text = productComments?.comments?[cellIndex].userName
        cell.commentLbl.text = productComments?.comments?[cellIndex].comment
        
        return cell
    }
    
    
}

